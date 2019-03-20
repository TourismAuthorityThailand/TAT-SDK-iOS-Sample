# Place Search and Place Detail <a name="PlaceSearch"></a>

This sample demonstrates how to use `TATPlacesSearch` to search places from `TATPlacesSearchParameter` and get the detail of placce such as: Attraction, Accomodation, Restaurant, Shopping and Other type by search conditions

## Place Search parameters
 * **keyword** *such as name, latitude and longitude of place or mapcode.*
 * **categories** *use `TATCategory` supported `TATCategory.attraction`, `TATCategory.accommodation`, `TATCategory.restaurant`, `TATCategory.shop` and `TATCategory.other`*
 * **latitude and longitude** value *when you want to search events around you.*
 * **provinceName**
 * **radius** *(Maximum radius is 200 Kilometer. The unit is Kilometer)*
 * **numberOfResult** *(Maximum result is 50 items)*
 * **language** *use `TATLanguage.english` for English display or `TATLanguage.thai` for Thai display.*

## How to use the sample
 1. Enter keyword to search.
 2. Choose categories one or more options.
 3. Select `Nearby location` when used the location reference search result.
 4. Click `Search` button to get place result.
 5. When you clicked a result that show the detail of place by category.


### Place Search
<img src="PlaceSearch_ios.png" width="30%" style="border: 1px solid lightgray;">

### Search Result
<img src="SearchResult_ios.png" width="30%" style="border: 1px solid lightgray;">

## Place Detail parameters
 * **placeID** *from place search result.*
 * **language** *use `TATLanguage.english` for English display or `TATLanguage.thai` for Thai display.*

## How to use the sample
 1. Choose one of place from result.
 2. Show the result of the selected place.

### Place Detail
<img src="PlaceDetail_ios.png" width="30%" style="border: 1px solid lightgray;">
