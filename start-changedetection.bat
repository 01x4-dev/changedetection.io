@echo off

:docker_loop
timeout 3
docker version
IF %errorlevel% NEQ 0 GOTO docker_loop
cd %homepath%\Documents\GitHub\changedetection.io\
docker compose up -d

:browser_loop
timeout 3
FOR /f "delims=" %%a in ('docker container inspect -f '{{.State.Status}}' changedetection') do @set changedetection_status=%%a
IF %changedetection_status%=='running' (
    timeout 3
    start brave --incognito "http://localhost:8080"
) ELSE (
    GOTO :browser_loop
)