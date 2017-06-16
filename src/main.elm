module Main exposing (..)

import Html exposing (..)
import Random exposing (..)
import SnakeModel exposing (..)
import SnakeMsg exposing (..)
import SnakeSubscriptions exposing (..)
import SnakeUpdate exposing (..)
import SnakeView exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = SnakeUpdate.update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { currentDirection = DOWN
      , nextDirection = DOWN
      , snake = [ { x = 2, y = 2 }, { x = 3, y = 2 }, { x = 4, y = 2 }, { x = 5, y = 2 } ]
      , board = startingBoard
      , fruit = { x = -1, y = -1 }
      , status = RUNNING
      }
    , Random.generate NewInt (Random.int 0 (gameHeight * gameWidth - 1))
    )


startingBoard : List (List Cell)
startingBoard =
    let
        ( xRange, yRange ) =
            ( List.range 0 gameWidth, List.range 0 gameHeight )
    in
    List.map (\y -> List.map (\x -> newCell x y) xRange) yRange


newCell : Int -> Int -> Cell
newCell x y =
    { x = x, y = y }
