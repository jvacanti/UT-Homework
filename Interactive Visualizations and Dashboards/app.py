import datetime as dt
import numpy as np
import pandas as pd
import sqlalchemy
import os
import json

from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, MetaData, inspect, Integer


from flask import (
    Flask,
    render_template,
    jsonify,
    request,
    redirect)


app = Flask(__name__)

engine = create_engine("sqlite:///db/belly_button_biodiversity.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to the table
otu = Base.classes.otu
samples = Base.classes.samples
samples_metadata = Base.classes.samples_metadata

# Create our session (link) from Python to the DB
session = Session(engine)


#################################################
# Flask Routes
#################################################

@app.route("/")
def home():
    """Render Home Page."""
    return render_template("index.html")

@app.route("/names")
def sampledata():
    """List of sample names"""

    # query for the top 10 samples
    results = session.query(samples).statement

    samples_df = pd.read_sql_query(results, session.bind)
    samples_df.drop("otu_id", axis=1, inplace=True)
    return jsonify(list(samples_df.columns))

@app.route("/otu")
def otu_data():

    results = session.query(otu.lowest_taxonomic_unit_found).all()

    # otu_df = pd.read_sql_query(results, session.bind)
    # otu_df.drop("otu_id", axis=1, inplace=True)
    # otu_json = otu_df.to_json(orient=records)
    return jsonify(list(np.ravel(results)))

    


@app.route('/metadata/<sample>')
def meta(sample):

    results = session.query(samples_metadata.AGE,
                            samples_metadata.BBTYPE,
                            samples_metadata.ETHNICITY,
                            samples_metadata.GENDER,
                            samples_metadata.LOCATION,
                            samples_metadata.SAMPLEID).\
                            filter(samples_metadata.SAMPLEID==sample[3:]).all()
    
    result_dict = {}
    for result in results:
        result_dict["sampleid"] = result[5]

    return jsonify(result_dict)
    # return jsonify(results[0])

@app.route('/wfreq/<sample>')
def wfreq(sample):
    """Weekly Washing Frequency as a number."""

    results = session.query(samples_metadata.WFREQ).filter(samples_metadata.SAMPLEID==sample[3:]).all()

    return jsonify(results[0][0])

# @app.route('/samples/<sample>')
#     """OTU IDs and Sample Values for a given sample."""

    plot_trace = {
                "x": df["name"].values.tolist(),
                "y": df["score"].values.tolist(),
                "type": "bar"
        }
        return jsonify(plot_trace)

if __name__ == '__main__':
    app.run(debug=True)