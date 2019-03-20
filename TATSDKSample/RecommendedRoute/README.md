# Recommended Route Search and Recommended Route Detail <a name="RecommendedRoute"></a>

This sample demonstrates how to use `TATGetRoutes` to search routes from `TATGetRoutesParameter` and get the detail of routes such as: number of trips day or trips region by search conditions

## Route Search parameters
 * **numberOfDays**
 * **latitude and longitude** value *when you want to search routes around you.*
 * **region** *when you want to search route in specific region by using TATRegion.*
 * **language** *use `TATLanguage.english` for English display or `TATLanguage.thai` for Thai display.*

## How to use the sample
 1. Specify number of day(Optional).
 2. Choose Region(Optional).
 3. Select `Nearby location` when used the location reference search result.
 4. Click `Search` button to get place result.
 5. When you clicked a result that show the detail of route.

### Recommended Routes Search
<img src="RecommendedRouteSearch.png" width="30%" style="border: 1px solid lightgray;">

### Recommended Routes Result
<img src="RecommendedRouteList.png" width="30%" style="border: 1px solid lightgray;">

## Route Detail parameters
 * **routeId** *from route search result*
 * **language** *use `TATLanguage.english` for English display or `TATLanguage.thai` for Thai display.*

## How to use the sample
 1. Choose one of route from result.
 2. Show the result of the selected route.
 3. When you click view on map will display route path on map.

### Route Detail
<img src="RecommendedRouteDetail.png" width="30%" style="border: 1px solid lightgray;">

### Route on Map
<img src="RecommendedRouteMap.png" width="30%" style="border: 1px solid lightgray;">
