module SnakeMsg exposing (..)

import SnakeModel exposing (..)
import Time exposing (Time, second)
import Keyboard

type Msg
    = Tick Time
    | KeyMsg Keyboard.KeyCode
    | NewInt Int
