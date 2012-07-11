class Pageobject < ActiveRecord::Base
  belongs_to :page
  
  # The object type hash
  TYPE = {  0 => 'Text',
            1 => 'Image',
            2 => 'Video'}
  # the color hash          
  COLOR = { 0 => 'black',
            1 => 'red',
            2 => 'green',
            3 => 'blue',
            4 => 'yellow',
            5 => 'gray'}
end
