#include <WiFi.h>
#include "ThingSpeak.h"

#include <HTTPClient.h>

const char* ssid = "Redmi 9";            //WiFi name
const char* password = "bawa@1234";        //WiFi Password
WiFiClient  client;
// Domain Name with full URL Path for HTTP POST Request
const char* serverName = "http://api.thingspeak.com/update";
// Service API Key
String apiKey = "92855LFT6LDTVHGO";

unsigned long lastTime = 0;
unsigned long timerDelay = 10000;
#define vibrationPin 32           // Pin used for Vibration sensor
#define pirPin 33                 // Pin used for PIR sensor
#define LDRPin 39                // Pin used for LDR sensor

void setup() {
  Serial.begin(9600);
  pinMode(pirPin, INPUT);
  pinMode(vibrationPin, INPUT);
  pinMode(LDRPin,INPUT);
  WiFi.mode(WIFI_STA);
  ThingSpeak.begin(client);
}

void loop() {
  if ((millis() - lastTime) > timerDelay) {
    // Connect or reconnect to WiFi
    if (WiFi.status() != WL_CONNECTED) {
      Serial.print("Attempting to connect");
      while (WiFi.status() != WL_CONNECTED) {
        WiFi.begin(ssid, password);
        delay(2000);
      }
      Serial.println("\nConnected.");
    }
    // Getting values of Motion Detection Status using PIR Sensor
    bool pirState;
    if (digitalRead(pirPin) == HIGH) {
      pirState = true;
    } else {
        pirState = false;
    }
    if (pirState == true) {
      Serial.println("Motion Detected");
    }
    if (pirState == false) {
      Serial.println("Motion Stopped");
    }
    // Getting Value of Vibration using SW18010P Sensor
    int vibration = analogRead(vibrationPin);
    vibration = map(vibration,4095,0,1000,0);
    Serial.print("Vibration Value: ");
    Serial.println(vibration);

    //Getting Value of Light using LDR Sensor
    int light = analogRead(LDRPin);
    light = map(light,0,1023,0,1000);
    Serial.print("Value of Light: ");
    Serial.print(light);
    Serial.println(" lux");
    
    delay(1000);
    HTTPClient http;
    http.begin(client, serverName);
    // Specify content-type header
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    // Data to send with HTTP POST
    String httpRequestData = "api_key=" + apiKey +"&field2=" + pirState + "&field3=" + vibration + "&field4=" + light;
    // Send HTTP POST request
    int httpResponseCode = http.POST(httpRequestData);

    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);

    http.end();
    lastTime = millis();
  }
}
