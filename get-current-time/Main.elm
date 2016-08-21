port module Main exposing (..)

import Date exposing (..)
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task exposing (..)
import Time exposing (..)
import Basics.Extra exposing (never)


-- main


main : Program Never
main =
    App.program
        { init = ( Model 0, getCurrentTime )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { currentTime : Float
    }



-- update


type Msg
    = TimeSuccess Float
    | RefreshTime


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TimeSuccess t ->
            ( Model t, Cmd.none )

        RefreshTime ->
            ( model, getCurrentTime )


getCurrentTime : Cmd Msg
getCurrentTime =
    Task.perform never TimeSuccess Time.now



-- Subs


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- view


view : Model -> Html Msg
view model =
    div []
        [ p [] [ text ("The Time Is: " ++ (model.currentTime |> Date.fromTime |> toString)) ]
        , button [ type' "button", onClick RefreshTime ] [ text "Refresh Time" ]
        ]
