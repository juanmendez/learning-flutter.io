# learning_flutter

Learning how to make applications in Flutter

## Getting Started

Doing something fun with the weather.

As the weather api provides the city name based on its location tracking. I thought of also combining that
functionality with searching for an image from [Pexels](https://www.pexels.com/). In a similar fashion I needed to make
a network call along with a header wrapping an authenticated api key provided by Pexels.

Every time the user searches for a city, or its current location, the photo api searches using the city name, and
the nice thing is the photo collection being returned only comes with one photo. If there are no photos
or a network issue, then the Golden Gate picture stored in assets gets displayed.

Here is a search based on The Plurinational State of Bolivia and Chicago, the Windy City!

<img width="472" alt="image" src="https://user-images.githubusercontent.com/3371622/89745224-12872980-da78-11ea-98b3-159b89ae0ca6.png">
<img width="472" alt="image" src="https://user-images.githubusercontent.com/3371622/89745211-f71c1e80-da77-11ea-9bcf-0fc88db421cd.png">
<img width="472" alt="image" src="https://user-images.githubusercontent.com/3371622/89745217-026f4a00-da78-11ea-8ff4-990f57c087ad.png">
