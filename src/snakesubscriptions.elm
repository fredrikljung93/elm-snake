module SnakeSubscriptions exposing (..)

import SnakeMsg exposing (..)
import SnakeModel exposing (..)

import Time exposing (Time, second)
import Keyboard

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
    [ Time.every (Time.millisecond*100) Tick
    , (Keyboard.downs KeyMsg)
    ]
