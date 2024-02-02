import python_weather
import asyncio
import os
import time
import sys
import json

async def getweather():
    async with python_weather.Client(unit=python_weather.METRIC) as client:
        weather = await client.get('Jyvaskyla')

        sys.stdout.write("\n")
        sys.stdout.flush()
        sys.stdout.write(json.dumps({
            "text": 
                str(weather.current.temperature) + " " 
                + weather.current.description,
            "class": "custom-weather",
            "alt": "weather"
        }))
        sys.stdout.write("\n")
        sys.stdout.flush()


while True:
    asyncio.run(getweather())
    time.sleep(15 * 60)
