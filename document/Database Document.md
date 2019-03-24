# *Never Get Grey* Database Document

## Ngg_User
| name | type | key | null | default | desc |
|---|---|---|---|---|---|
| id | varchar | primary key | N | | 主键 uuid |
| username | varchar | | N | | 用户名 |
| password | varchar | | N | | 密码 |
| signNum | long | | N | 0 | 登录次数 |
| status | boolean | | N | true | |
| deleted | boolean | | N | false | |
| createdAt | timestamp | | N | CURRENT TIMESTAMP | |
| updatedAt | timestamp | | N | TIMESTAMP | |
| deletedAt | timestamp | | N | TIMESTAMP | |

## Ngg_Sign_Log
| name | type | key | null | default | desc |
|---|---|---|---|---|---|
| id | varchar | primary key | N | | 主键 uuid |
| uId | long | FK | N | | 外键 Ngg_User.id |
| ip | varchar | | N | | 登录ip |
| platform | varchar | | Y | | 平台 |
| createdAt | timestamp | | N | CURRENT TIMESTAMP | |

## Ngg_Playlist
| name | type | key | null | default | desc |
|---|---|---|---|---|---|
| id | varchar | primary key | N | | 主键 uuid |
| uId | long | FK | N | | 外键 Ngg_User.id |
| name | varchar | | N | | 名称 |
| deleted | boolean | | N | false | |
| createdAt | timestamp | | N | CURRENT TIMESTAMP | |
| updatedAt | timestamp | | N | TIMESTAMP | |
| deletedAt | timestamp | | N | TIMESTAMP | |

## Ngg_Song
| name | type | key | null | default | desc |
|---|---|---|---|---|---|
| id | varchar | primary key | N | | 主键 uuid |
| pId | long | FK | N | | 外键 Ngg_Playlist.id |
| name | varchar | | N | | 名称 |
| singer | varchar | | Y | | 歌手 |
| album | varchar | | Y | | 封面地址 |
| lyrics | varchar | | Y | | 歌词地址 |
| url | varchar | | N | | 文件地址 |
| deleted | boolean | | N | false | |
| createdAt | timestamp | | N | CURRENT TIMESTAMP | |
| updatedAt | timestamp | | N | TIMESTAMP | |
| deletedAt | timestamp | | N | TIMESTAMP | |
