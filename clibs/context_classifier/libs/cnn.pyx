import matplotlib.pyplot as plt
import numpy as np
import os
import PIL
import tensorflow as tf

import keras
from keras import layers
from keras import Sequential

#from tensorflow import keras
#from tensorflow.keras import layers
#from tensorflow.keras.models import Sequential

import pathlib

from libs.utils import resize_images

### Global Variables
# define image data location
data_dir = "../../datasets/collect_frames_for_context"
# define image data dimensions
cdef int img_height = 200
cdef int img_width = 300
# define class number
cdef int num_classes = 3
# define model params
cdef int batch_size = 32
cdef int epochs=10
# define the save location
model_build_path = "models/context_classifier"

class cclassifier():
  def __init__(self):
    # setup static variables
    # define model params
    self.model = None
    self.AUTOTUNE = tf.data.experimental.AUTOTUNE

  def data_input(self):
    # Setup data input pipeline

    # scale the images to 300x200
    resize_images()

    # create path loaction
    data_path = pathlib.Path(data_dir)
    
    # create training set (80%)
    self.train_ds = tf.keras.preprocessing.image_dataset_from_directory(
      data_path,
      validation_split=0.2,
      subset="training",
      seed=123,
      image_size=(img_height, img_width),
      batch_size=batch_size)
    # create validation data (20%)
    self.val_ds = tf.keras.preprocessing.image_dataset_from_directory(
      data_path,
      validation_split=0.2,
      subset="validation",
      seed=123,
      image_size=(img_height, img_width),
      batch_size=batch_size)
    # declare classnames
    self.class_names = self.train_ds.class_names
    print("class names:")
    print(self.class_names)
    # Pre Cache data for performance
    self.train_ds = self.train_ds.cache().shuffle(1000).prefetch(buffer_size=self.AUTOTUNE)
    self.val_ds = self.val_ds.cache().prefetch(buffer_size=self.AUTOTUNE)

  def build_model(self):
    # Build the Model
    normalization_layer = layers.experimental.preprocessing.Rescaling(1./255)
    self.model = Sequential([
      layers.experimental.preprocessing.Rescaling(1./255, input_shape=(img_height, img_width, 3)),
      layers.Conv2D(16, 3, padding='same', activation='relu'),
      layers.MaxPooling2D(),
      layers.Conv2D(32, 3, padding='same', activation='relu'),
      layers.MaxPooling2D(),
      layers.Conv2D(64, 3, padding='same', activation='relu'),
      layers.MaxPooling2D(),
      layers.Flatten(),
      layers.Dense(128, activation='relu'),
      layers.Dense(num_classes)
    ])
    self.model.compile(optimizer='adam',
                loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
                metrics=['accuracy'])
    self.model.summary()

  def train_model(self):
    # Run training
    print("Training Model")
    self.history = self.model.fit(
      self.train_ds,
      validation_data=self.val_ds,
      epochs=epochs
    )
    print("Training Complete")

  def save_model(self):
    # Save the model to file
    print("Saving Model")
    self.model.save(model_build_path) 

  def open_model(self):
    print("Opening Model")
    self.model = tf.keras.models.load_model(model_build_path)

    # Check its architecture
    self.model.summary()


  def plot_hist(self):
    print("Plotting Results")
    # plot the results from training the model
    acc = self.history.history['accuracy']
    val_acc = self.history.history['val_accuracy']

    loss=self.history.history['loss']
    val_loss=self.history.history['val_loss']

    epochs_range = range(epochs)

    plt.figure(figsize=(8, 8))
    plt.subplot(1, 2, 1)
    plt.plot(epochs_range, acc, label='Training Accuracy')
    plt.plot(epochs_range, val_acc, label='Validation Accuracy')
    plt.legend(loc='lower right')
    plt.title('Training and Validation Accuracy')

    plt.subplot(1, 2, 2)
    plt.plot(epochs_range, loss, label='Training Loss')
    plt.plot(epochs_range, val_loss, label='Validation Loss')
    plt.legend(loc='upper right')
    plt.title('Training and Validation Loss')
    plt.show()

