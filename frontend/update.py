import pandas as pd
import streamlit as st
from database import view_all_data, view_only_subject_number, edit_subject_data


def update():
    result = view_all_data()
    # st.write(result) 
    df = pd.DataFrame(result, columns=["S_ID", "subject_name"]) 
    with st.expander("Current subjects:"):
        st.dataframe(df)
    list_of_subjects = [i[0] for i in view_only_subject_number()]
    selected_subject = st.selectbox("subject to Edit", list_of_subjects)
    # selected_result = get_dealer(selected_dealer)
    # st.write(selected_result)
    if selected_subject:
        # Layout of Create
        if st.button("Update subjects"):
            edit_subject_data('Dystopian', selected_subject)
            st.success("Successfully updated subject name of subjects :: {} to :: {}".format(selected_subject, 'Dystopian'))

    result2 = view_all_data()
    df2 = pd.DataFrame(result2, columns=["S_ID", "subject_name"])
    with st.expander("Updated subjects data"):
        st.dataframe(df2)