import pandas as pd
import streamlit as st
from database import pie_chart
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import random

def pie():
    result = pie_chart()
    df = pd.DataFrame(result, columns=["S_ID","subject_name","COUNT(B_ID)"])
    with st.expander("View genre distribution:"):
        st.dataframe(df)
    labels = df["subject_name"].tolist() 
    c = df["COUNT(B_ID)"].tolist()
    colors = ['red','orange','yellow','green','cyan','violet','indigo','purple','pink','silver','gold','beige','salmon','brown','grey','maroon']
    # explode = (0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1)
    fig1, ax1 = plt.subplots()
    ax1.pie(c, labels=labels, autopct='%1.1f%%',startangle=90,textprops={'fontsize': 6},colors=colors)
    ax1.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.
    st.pyplot(fig1)
    # st.caption(c)
    # st.caption(labels)
    # st.caption(df)   


