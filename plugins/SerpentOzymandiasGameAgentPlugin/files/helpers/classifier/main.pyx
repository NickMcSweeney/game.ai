import tensorflow as tf

#MODEL_PATH = "../../ml_models/context_classifier"
MODEL_PATH = "clibs/context_classifier/models/context_classifier"

class Classifier:

  def __init__(self):
    print("Opening Model")
    self.model = tf.keras.models.load_model(MODEL_PATH)

    # Check its architecture
    self.model.summary()

  def classify(self, image):
    return "none"
