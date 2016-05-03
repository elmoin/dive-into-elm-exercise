module Main (..) where

import Html exposing (..)
import Html.Events exposing (onClick)
import Signal exposing (..)
import StartApp.Simple as StartApp


-- MODEL


type alias Weather =
  { day : String, max : Int, min : Int, description : String }


type alias City =
  String


type alias Model =
  { city : City, forecast : List Weather }



-- forecast model data of Hamburg


forecast_hh : Model
forecast_hh =
  { city = "Hamburg"
  , forecast =
      [ { day = "TUE", max = 19, min = 8, description = "Light Rain" }
      , { day = "WED", max = 15, min = 4, description = "Mostly Sunny" }
      , { day = "THU", max = 17, min = 6, description = "Sunny" }
      , { day = "FRI", max = 20, min = 10, description = "Sunny" }
      , { day = "SAT", max = 22, min = 11, description = "Sunny" }
      , { day = "SUN", max = 22, min = 12, description = "Sunny" }
      ]
  }

forecast_berlin : Model
forecast_berlin =
  { city = "Berlin"
  , forecast =
      [ { day = "TUE", max = 18, min = 7, description = "Partly Cloudy" }
       , { day = "WED", max = 16, min = 4, description = "Cloudy" }
       , { day = "THU", max = 19, min = 6, description = "Sunny" }
       , { day = "FRI", max = 21, min = 10, description = "Mostly Sunny" }
       , { day = "SAT", max = 23, min = 11, description = "Mostly Sunny" }
       , { day = "SUN", max = 24, min = 12, description = "Mostly Sunny" }
       ]
  }
-- empty model data


initalModel : Model
initalModel =
  forecast_hh



-- UPDATE


type Action
  = Reset
  | Toggle Model


update : Action -> Model -> Model
update action model =
  case action of
    Reset ->
      initalModel

    Toggle currentModel ->
      if currentModel == forecast_hh then forecast_berlin else forecast_hh


-- VIEW


forecastListView : List Weather -> Html
forecastListView forecast =
  let
    -- table header
    header =
      tr
        []
        [ th [] [ text "Day" ]
        , th [] [ text "Max" ]
        , th [] [ text "Min" ]
        , th [] [ text "Detail" ]
        ]

    -- table content
    list =
      case forecast of
        [] ->
          []

        detail ->
          List.map forecastDetailView detail
  in
    table
      []
      [ thead
          []
          [ header ]
      , tbody
          []
          list
      ]


forecastDetailView : Weather -> Html
forecastDetailView detail =
  tr
    []
    [ td [] [ text detail.day ]
    , td [] [ text (toString detail.max ++ "°C") ]
    , td [] [ text (toString detail.min ++ "°C") ]
    , td [] [ text detail.description ]
    ]


cityView : City -> Html
cityView city =
  h1 [] [ text city ]


view : Address Action -> Model -> Html
view address model =
  div
    []
    [ button
        [ onClick address (Toggle model) ]
        [ text "Toggle" ]
    , button
        [ onClick address Reset ]
        [ text "Reset" ]
    , cityView model.city
    , forecastListView model.forecast
    ]


main : Signal Html.Html
main =
  StartApp.start { model = initalModel, view = view, update = update }
