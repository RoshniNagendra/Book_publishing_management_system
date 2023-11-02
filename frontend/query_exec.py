import streamlit as st
from database import qexec
import pandas as pd

def query():
    q = st.text_input("Enter query:")
    result = qexec(q)
    df = pd.DataFrame(result)
    with st.expander("View results:"):
        st.dataframe(df)
    