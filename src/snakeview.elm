module SnakeView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List.Extra exposing (..)
import SnakeModel exposing (..)
import SnakeMsg exposing (..)


cellPixelLengthInt : Int
cellPixelLengthInt =
    32
    
cellPixelLength : String
cellPixelLength =
    String.concat [ toString cellPixelLengthInt, "px" ]


view : Model -> Html Msg
view model =
    div []
        [ gameBoard model
        , h2 [] [ text (toString (List.length model.snake - 4)) ]
        , h1 []
            [ text
                (if model.status == GAMEOVER then
                    "Game Over"
                 else
                    ""
                )
            ]
        ]


getColor : Model -> Cell -> String
getColor model cell =
    if List.member cell model.snake then
        "green"
    else if model.fruit == cell then
        "red"
    else
        "white"


getImageUrl : Model -> Cell -> String
getImageUrl model cell =
    let
        snakeHead =
            Maybe.withDefault (Cell -1 -1) (List.Extra.last model.snake)
    in
    if cell == snakeHead && model.currentDirection == UP then
        "headup.png"
    else if cell == snakeHead && model.currentDirection == DOWN then
        "headdown.png"
    else if cell == snakeHead && model.currentDirection == LEFT then
        "headleft.png"
    else if cell == snakeHead && model.currentDirection == RIGHT then
        "headright.png"
    else if List.member cell model.snake then
        "snakebody.png"
    else if model.fruit == cell then
        "marlboro.png"
    else
        "empty.png"


gameBoard : Model -> Html Msg
gameBoard model =
    table
        [ style
            [ ( "border-collapse", "collapse" )
            , ( "border", "40px solid black" )
            ]
        ]
        (List.map (\l -> rowView model l) model.board)


rowView : Model -> List Cell -> Html Msg
rowView model row =
    tr
        [ style
            []
        ]
        (List.map
            (\cell ->
                td
                    [ style
                        [ ( "width", cellPixelLength )
                        , ( "height", cellPixelLength )
                        , ( "min-width", cellPixelLength )
                        , ( "min-height", cellPixelLength )
                        , ( "max-width", cellPixelLength )
                        , ( "max-height", cellPixelLength )
                        , ( "padding", "0px" )
                        ]
                    ]
                    [ img
                        [ src (getImageUrl model cell)
                        , height cellPixelLengthInt
                        , width cellPixelLengthInt
                        , style
                            [ ( "margin", "0" )
                            , ( "padding", "0" )
                            , ( "outline", "none" )
                            , ( "position", "absolute" )
                            ]
                        ]
                        []
                    ]
            )
            row
        )
