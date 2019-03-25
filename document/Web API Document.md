# *Never Get Grey* Web API Document

## User Info API

```json
POST /api/userinfo

Body: 
{
  "username" : "xxx" [string],
  "password" : "xxx" [string],
  "private_key" : "xxx" [string]
}

Return:
{
  "code" : "xxx" [string]
  "data" : "xxx" [any]
}
```

```json
GET /api/userinfo/{username}?auth_key={auth_key}
Body: 
{}

Return:
{
  "code" : "xxx" [string]
  "data" : "xxx" [any]
}
```

## Session API

```json
POST /api/session

Body:
{
  "username" : "xxx" [string],
  "password" : "xxx" [string]
}

Return:
{
  "code" : "xxx" [string],
  "data" : {
    "auth_key" : "xxx" [string]
  }
}
```

```json
DELETE /api/session

Body:
{
  "auth_key" : "xxx" [string],
}

Return:
{
  "code" : "xxx" [string]
  "data" : "xxx" [any]
}
```

## Playlist Info API

```json
GET /api/playlists/auth_key={auth_key}

Body:
{}

Return:
{
  "code" : "xxx" [string]
  "data" : {
    "playlist" : [
      {
  			"uid" : "xxx" [string],
        "name" : "xxx" [string],
        "songs" : [
          {
            "name" : "xxx" [string],
            "artist" : "xxx" [string],
            "album" : "xxx" [string],
            "uid" : "xxx" [string]
          },
          ...
        ]
      },
      ...
    ]
  }
}
```

```json
POST /api/playlists
Body:
{
  "auth_key" : "xxx" [string],
  "name" : "xxx" [string]
}

Return:
{
  "code" : "xxx" [string],
  "data" : {
    "uid" : "xxx" [string]
  }
}
```
```json
PUT /api/playlists
Body:
{
  "auth_key" : "xxx" [string],
  "uid" : "xxx" [string],
  "new_name" : "xxx" [string]
}
```

```json
DELETE /api/playlists

Body:
{
  "auth_key" : "xxx" [string],
  "uid" : "xxx" [string]
}

Return:
{
  "code" : "xxx" [string],
  "data" : "xxx" [any]
}
```

## Song Info API

```json
GET /api/songs/uid?auth_key={auth_key}

Body:
{}

Return:
{
  "code" : "xxx" [string],
  "data" : {
    "album_img" : "xxx" [base64 string],
    "lyrics" : "xxx" [string],
  }
}
```

```json
DELETE /api/songs

Body:
{
  "auth_key" : "xxx" [string],
  "song_uid" : "xxx" [string],
  "playlist_uid" : "xxx" [string]
}

Return:
{
  "code" : "xxx" [string],
  "data" : "xxx" [any]
}
```

```json
POST /api/songs
Body:
{
  "auth_key" : "xxx" [string],
  "song_uid" : "xxx" [string],
  "playlist_uid" : "xxx" [string]
}

Return:
{
  "code" : "xxx" [string],
  "data" : "xxx" [any]
}
```

