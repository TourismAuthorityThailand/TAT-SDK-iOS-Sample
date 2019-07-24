# Feed news and Get News's detail

This sample demonstrates how to use `TATNews` to feed the news and how to get news' detail from TAT SDK.

# Feed News
How to use `TATNews` to feed the news by `feed` method.
## Parameters
 * **language** use `TATLanguage` to set display language. *supported `.english` for display in English or `.thai` for display in Thai.*

## How to use the sample
 1. The results are sorted according by latest published date.

### Feed News
![](GetListOfNews_ios.png)

# Get News's detail
How to use `TATNews` to get the news's detail from feed news result by `getDetail` method with news id.
## Parameters
 * **id** The News ID from feed news result.
 * **language** use `TATLanguage` to set display language. *supported `.english` for display in English or `.thai` for display in Thai.*

## How to use the sample
 1. Choose one of news from result.
 2. Show the result of the selected news.

### Get News's detail
![](NewsDetail_ios.png)