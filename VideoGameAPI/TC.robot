*** Setting ***
Library    RequestsLibrary
Library    Collections

#to run ==> robot VideoGameAPI/TC.robot

#Bu sayfadaki api TESTI ICIN:
#  1.go==> gradle.org releases and install it, C: ye yukleyip bin file advanced ayarlarda path ekle
#  2. https://github.com/james-willett/VideoGameDB ==> bilgisayara indir, unzip.
#  3. cmd ac ve githubdan unzip aettigin dosyaya gecis yap ve run this command==> gradlew bootRun
#  4. http://localhost:8080/swagger-ui/index.html#/ bu linke git.
#    **boylece kendi localimizde bir API sitesi elde etmis olduk. **
*** Variables ***
${base_url}=    http://localhost:8080

*** Test Cases ***
TC1:Returns all the video games(GET)
    #1.create session
    create session    mysession    ${base_url}
    #2. get request with relative URL
    ${response}=    get request    mysession    /app/videogames
    log to console    ${response.status_code}
    log to console    ${response.content}

    #VALIDATIONS
#    ${response.status_code}==> integer ve asagidaki 200==> string oldugu icin convert ettik
    ${status_code}=  convert to string    ${response.status_code}
    should be equal     ${status_code}    200

TC2:Add a new video game(POST)

    create session    mysession    ${base_url}
    ${body}=    create dictionary   id=100    name=Spider-Man    releaseDate=2022-01-29T21:57:58.730Z    reviewScore=5    category=Adventure    rating=Universal
    ${header}=    create dictionary    Content-Type=application/json
    ${response}=    post request    mysession   /app/videogames     data=${body}    headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

        #VALIDATIONS
#    ${response.status_code}==> integer ve asagidaki 200==> string oldugu icin convert ettik
    ${status_code}=  convert to string    ${response.status_code}
    should be equal     ${status_code}    200

    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    Record Added Successfully

TC3:Return the details of a single game bi ID(GET)
    #1.create session
    create session    mysession    ${base_url}
    #2. get request with relative URL
    ${response}=    get request    mysession    /app/videogames/100
    log to console    ${response.status_code}
    log to console    ${response.content}

    #VALIDATIONS
#    ${response.status_code}==> integer ve asagidaki 200==> string oldugu icin convert ettik
    ${status_code}=  convert to string    ${response.status_code}
    should be equal     ${status_code}    200

    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    Spider-Man    #name of game

TC4:Update a existing video game by specifying a new body(PUT)

    create session    mysession    ${base_url}
    ${body}=    create dictionary   id=100    name=Pacman    releaseDate=2022-01-29T21:57:58.730Z    reviewScore=5    category=Adventure    rating=Universal
    ${header}=    create dictionary    Content-Type=application/json
    ${response}=    put request    mysession   /app/videogames/100     data=${body}    headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

        #VALIDATIONS
#    ${response.status_code}==> integer ve asagidaki 200==> string oldugu icin convert ettik
    ${status_code}=  convert to string    ${response.status_code}
    should be equal     ${status_code}    200

    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    Pacman

TC5:Delete a video game by ID(Delete)

    create session    mysession    ${base_url}
    ${response}=    delete request    mysession   /app/videogames/100

        #VALIDATIONS
#    ${response.status_code}==> integer ve asagidaki 200==> string oldugu icin convert ettik
    ${status_code}=  convert to string    ${response.status_code}
    should be equal     ${status_code}    200

    ${res_body}=    convert to string    ${response.content}
    should contain    ${res_body}    Record Deleted Succesfully