from libs.cnn import *

def train_classifier():
  cnn = cclassifier()
  cnn.data_input()
  cnn.build_model()
  cnn.train_model()
  
  cnn.save_model()

  cnn.plot_hist()
