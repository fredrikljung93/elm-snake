module SnakeUpdate exposing (..)

import Keyboard
import List.Extra exposing (..)
import Random exposing (..)
import SnakeModel exposing (..)
import SnakeMsg exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            let
                nextSnake =
                    getNextSnake model
            in
            if snakeOutOfBounds nextSnake || snakeEatingItself nextSnake then
                ( { model | status = GAMEOVER }, Cmd.none )
            else if List.member model.fruit nextSnake then
                ( eatFruit model, Random.generate NewInt (Random.int 0 (gameHeight * gameWidth - 1)) )
            else
                ( { model | snake = nextSnake, currentDirection = model.nextDirection }, Cmd.none )

        KeyMsg code ->
            if model.status == RUNNING then
                ( handleKeyMsg model code, Cmd.none )
            else
                ( model, Cmd.none )

        NewInt randomInt ->
            let
                ( x, y ) =
                    ( randomInt % gameHeight, randomInt // gameWidth )
            in
            if List.member (Cell x y) model.snake then
                ( { model | fruit = Cell -1 -1 }, Random.generate NewInt (Random.int 0 (gameHeight * gameWidth - 1)) )
            else
                ( { model | fruit = Cell x y }, Cmd.none )


getNextSnake : Model -> Snake
getNextSnake model =
    let
        snakeLast =
            Maybe.withDefault (Cell 0 0) (List.Extra.last model.snake)
    in
    if model.nextDirection == RIGHT then
        List.append (List.drop 1 model.snake) [ Cell (snakeLast.x + 1) snakeLast.y ]
    else if model.nextDirection == LEFT then
        List.append (List.drop 1 model.snake) [ Cell (snakeLast.x - 1) snakeLast.y ]
    else if model.nextDirection == UP then
        List.append (List.drop 1 model.snake) [ Cell snakeLast.x (snakeLast.y - 1) ]
    else
        List.append (List.drop 1 model.snake) [ Cell snakeLast.x (snakeLast.y + 1) ]


handleKeyMsg : Model -> Keyboard.KeyCode -> Model
handleKeyMsg model code =
    if code == 38 && model.currentDirection /= DOWN then
        { model | nextDirection = UP }
    else if code == 40 && model.currentDirection /= UP then
        { model | nextDirection = DOWN }
    else if code == 37 && model.currentDirection /= RIGHT then
        { model | nextDirection = LEFT }
    else if code == 39 && model.currentDirection /= LEFT then
        { model | nextDirection = RIGHT }
    else
        model


snakeOutOfBounds : Snake -> Bool
snakeOutOfBounds snake =
    List.any (\c -> c.x < 0 || c.x > gameWidth || c.y < 0 || c.y > gameHeight) snake


snakeEatingItself : Snake -> Bool
snakeEatingItself snake =
    List.any (\c -> List.length (List.filter (\cc -> cc.x == c.x && cc.y == c.y) snake) > 1) snake


eatFruit : Model -> Model
eatFruit model =
    { model | snake = List.append model.snake [ model.fruit ], fruit = Cell -1 -1 }
