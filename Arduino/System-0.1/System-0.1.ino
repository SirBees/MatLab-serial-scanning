String serial_data;
bool serial_data_ready; 

void setup()
{
  Serial.begin(9600);

  serial_data = "";
  serial_data_ready = false; 
}

void loop()
{
  serialProcess();

  if(serial_data_ready)
  {
    if(serial_data == "MATLAB")
    {
      Serial.println("ARDUINO");
    }

    serial_data = "";
    serial_data_ready = false; 
  }
}

void serialProcess()
{
  while(Serial.available())
  {
    if(Serial.peek() != '\n')
    {
      serial_data += Serial.read();
    }
    else
    {
      Serial.read();
      serial_data_ready = true;       
    }
  }
}
