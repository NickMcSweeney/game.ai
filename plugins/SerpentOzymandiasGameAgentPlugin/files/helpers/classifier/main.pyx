import tensorflow as tf
import numpy as np
import keras
import cv2

#MODEL_PATH = "../../ml_models/context_classifier"
MODEL_PATH = "clibs/context_classifier/models/context_classifier"
CLASSES = ["building", "none", "unit"]

class Classifier:

  def __init__(self):
    print("Opening Model")
    self.model = tf.keras.models.load_model(MODEL_PATH)

    # Check its architecture
    self.model.summary()

  def classify(self, image):
    img = self.preprocess_image(image)
    predictions = self.model.predict(img)
    print(predictions)
    score = tf.nn.softmax(predictions[0])
    print(score)
    return CLASSES[np.argmax(score)]

  def preprocess_image(self, img):
    res = cv2.resize(img, (300, 200), interpolation = cv2.INTER_CUBIC) 
    img_array = keras.preprocessing.image.img_to_array(res)
    img_array = tf.expand_dims(img_array, 0) # Create a batch
    return img_array
