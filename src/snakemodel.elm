module SnakeModel exposing (..)

type alias Model =
    { snake : List Cell
    , currentDirection : Direction
    , nextDirection : Direction
    , board : List (List Cell)
    , fruit: Cell
    , status : GameStatus
    }

type alias Snake = List Cell

type Direction = UP | DOWN | LEFT | RIGHT

type GameStatus = RUNNING | GAMEOVER

type alias Cell =
    { x : Int
    , y : Int
    }

gameWidth : Int
gameWidth =
    22
gameHeight : Int
gameHeight =
    22
