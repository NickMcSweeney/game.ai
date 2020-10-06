import pathlib 
import cv2
import numpy as np 

def resize_images():
  # Import the image data
  data_dir = "../../datasets/collect_frames_for_context"
  data_dir = pathlib.Path(data_dir)
  dirs = list(data_dir.glob('*'))
  for folder in dirs:
    files = list(folder.glob('*'))
    print("resizing %d images" % len(files))
    for f in files:
      try: 
          # Read image from disk. 
          img = cv2.imread(str(f)) 
        
          if(type(img) == type(None)):
            print("rm %s" % str(f))
            continue
          
          # Specify the size of image along with interploation methods. 
          # cv2.INTER_AREA is used for shrinking, whereas cv2.INTER_CUBIC 
          # is used for zooming. 
          res = cv2.resize(img, (300, 200), interpolation = cv2.INTER_CUBIC) 
        
          # Write image back to disk. 
          cv2.imwrite(str(f), res) 
        
      except IOError: 
          print ('Error while reading files !!!') 

