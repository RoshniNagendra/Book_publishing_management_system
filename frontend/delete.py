import pandas as pd
import streamlit as st
from database import view_all_data, view_only_subject_number, delete_data


def delete():
    result = view_all_data()
    # st.write(result) 
    df = pd.DataFrame(result, columns=["S_ID", "subject_name"]) 
    with st.expander("View all subjects"):
        st.dataframe(df)

    list_of_subjects = [i[0] for i in view_only_subject_number()]
    selected_subject = st.selectbox("Subject to Delete", list_of_subjects)
    st.warning("Do you want to delete ::{}".format(selected_subject))
    if st.button("Delete subject"):
        delete_data(selected_subject)
        st.success("subjects entry has been deleted successfully")
    new_result = view_all_data()
    df = pd.DataFrame(new_result, columns=["S_ID", "subject_name"]) 
    with st.expander("Updated subjects data"):
        st.dataframe(df)