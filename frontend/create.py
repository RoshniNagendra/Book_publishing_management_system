import streamlit as st
from database import add_data
def create():
    col1, col2 = st.columns(2)
    with col1:
        S_ID = st.text_input("Enter S_ID:")
    with col2:
        subject_name = st.text_input("Subject name:")
    if st.button("Add subject Details"):
        add_data(S_ID, subject_name)
        st.success("Successfully added subject with Number: {}".format(S_ID))