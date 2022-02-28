# FlySafe

## Intro
This application was developed as a final tech assignment of BTU/USAID iOS and Android development course. 
Main objective of the app is to make life easier for travelrs during covid pandemic, giving them quick access to various restricitons posed by destination countries.

## App architecture
FlySafe uses MVVM architecture with coordinator pattern. This way we make sure most of our classes are compatible with SOLID principles.
UI is written programatically to minimise merge conflicts. All API calls are made using protocol based network layer, for cleaner code and modular design.

## App Usage
As a guest user, you can select Departure airport, multiple connection airports, destination airport and flight date. Upon request, the app will return restrictions imposed by 
selected countries.

<img src="https://user-images.githubusercontent.com/5418067/155949630-043b53df-41d7-45e7-ad24-a13c8eea2ce9.PNG" width=40% height=40%>

As a authenticated user, you can save travel plan for later quick access. Saved information will be available for offline use as well. 
User can edit, and delete previously saved travel plans.

<img src="https://user-images.githubusercontent.com/5418067/155949910-6234b546-4dc3-4ab1-8e5f-b0700377f891.PNG" width=40% height=40%> <img src="https://user-images.githubusercontent.com/5418067/155950084-7ae39f10-6569-49a0-bd39-071dd228692d.PNG" width=40% height=40%>

 


