# マッピングAPI

本APIは、アイテムタイプのメタデータ項目と外部スキーマとのマッピング情報を管理・編集・取得するためのAPIです。

## 利用可能なロール

| ロール             | システム管理者 | リポジトリ管理者 | コミュニティ管理者 | 登録ユーザー | 一般ユーザー | ゲスト |
|--------------------|:--------------:|:----------------:|:------------------:|:------------:|:------------:|:------:|
| 利用可否           |       ○        |        ○         |         ×          |      ×       |      ×       |   ×    |

---

## エンドポイント

| 項番 | HTTP request                                         | 内容                                             |
|:----:|------------------------------------------------------|--------------------------------------------------|
| 1    | GET /admin/itemtypes/mapping/                        | マッピング画面を表示                             |
| 2    | GET /admin/itemtypes/mapping/<item_type_id>          | 指定アイテムタイプのマッピング画面を表示         |
| 3    | POST /admin/itemtypes/mapping                        | アイテムタイプのマッピング情報を登録・更新       |
| 4    | GET /admin/itemtypes/mapping/schema                  | 全てのマッピング用スキーマ情報を取得             |
| 5    | GET /admin/itemtypes/mapping/schema/<SchemaName>     | 指定スキーマ名のマッピング用スキーマ情報を取得   |

---

## 1. マッピング画面表示

### GET /admin/itemtypes/mapping/

#### 概要
アイテムタイプが存在しない場合はエラー画面、存在する場合はアイテムタイプ一覧(昇順)の先頭IDのマッピング画面へリダイレクトする。

#### 処理概要

- リクエスト
    ```shell
    curl -X GET "http://<WEKO3のURL>/admin/itemtypes/mapping/" -b <cookie情報>
    ```
    - -b オプション

        ログインページによるログインで得たcookie情報を指定する

- レスポンス
    - [200] アイテムタイプがない場合

        ```html
        <!DOCTYPE html>
        <html>
            <body>
                <p>You do not even have an itemtype.<br>
                Go to <a href="/admin/itemtypes/register/">Register Itemtype</a>!</p>
            </body>
        </html>
        ```

    - [302] アイテムタイプが存在する場合

        Locationヘッダで `/admin/itemtypes/mapping/<item_type_id>` へリダイレクトする。<br>
        <item_type_id>にはアイテムタイプ一覧(昇順)の先頭IDが指定される。


    - [400]不正なリクエストやサーバー内部エラー時のエラー画面
        ```html
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
        <title>WEKO3</title>
        <h1>Bad Request</h1>
        <p>The browser (or proxy) sent a request that this server could not understand.</p>
        ```

    - [403] 権限エラー

        ```html
        <!DOCTYPE html>
        <html>
            <head>
                <title>WEKO3</title>
            </head>
            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-10">
                            <h1><i class="fa fa-flash"></i>Permission required</h1>
                            <p>You do not have sufficient permissions to view this page.</p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
        ```

- APIの処理の流れ
    - アイテムタイプ一覧を取得する。
    - アイテムタイプが1件も存在しない場合はエラー画面（[error.html](https://github.com/RCOSDP/weko/blob/develop_v2.0.0/modules/weko-itemtypes-ui/weko_itemtypes_ui/templates/weko_itemtypes_ui/admin/error.html)）を表示する。
    - アイテムタイプ一覧の先頭のIDを用いて、指定アイテムタイプマッピング画面表示APIにリダイレクトする（HTTP 302）。
    - リダイレクト後は「[2. 指定アイテムタイプマッピング画面表示API](#2-指定アイテムタイプマッピング画面表示)」の処理に移行し、以降の画面表示・処理は2.の流れに従う。
    - 例外発生時は400エラーを返す。
    - 権限のないロールでアクセスした場合は403エラーを返す。

---

## 2. 指定アイテムタイプマッピング画面表示

### GET /admin/itemtypes/mapping/<item_type_id>

#### 概要
指定したアイテムタイプIDのマッピング画面を表示する。<br>
IDが存在しない場合はアイテムタイプ一覧(昇順)の先頭IDのマッピング画面にリダイレクトする。

#### 処理概要

- パスパラメータ
    | パラメータ名    | 型      | 必須 | 説明           |
    |----------------|---------|------|----------------|
    | item_type_id   | integer | ○    | アイテムタイプID|

- リクエスト
    ```shell
    curl -X GET "http://<WEKO3のURL>/admin/itemtypes/mapping/<item_type_id>" -b <cookie情報>
    ```
    - -b オプション

        ログインページによるログインで得たcookie情報を指定する

- レスポンス

    - [200] マッピング画面HTML

        実際の画面HTMLのテンプレートは[create_mapping.html](https://github.com/RCOSDP/weko/blob/develop_v2.0.0/modules/weko-itemtypes-ui/weko_itemtypes_ui/templates/weko_itemtypes_ui/admin/create_mapping.html)を参照。

        ```html
        <!DOCTYPE html>
        <html>
            <head>
                <title>WEKO3</title>
            </head>
            <body>
                <!-- 省略: create_mapping.html -->
            </body>
        </html>
        ```

        ※ ユーザーがシステム管理者以外（現状はリポジトリ管理者を想定）の場合

            「システムが付与したアイテムタイプ  (親)」 の「Schema（親）」項目が非活性になる。

    - [302] 指定IDが存在しない場合

        Locationヘッダで `/admin/itemtypes/mapping/<item_type_id>` へリダイレクトする。<br>
        <item_type_id>にはアイテムタイプ一覧(昇順)の先頭IDが指定される。

    - [400]不正なリクエストやサーバー内部エラー時のエラー画面
        ```html
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
        <title>WEKO3</title>
        <h1>Bad Request</h1>
        <p>The browser (or proxy) sent a request that this server could not understand.</p>
        ```

    - [403] 権限エラー
        ```html
        <!DOCTYPE html>
        <html>
            <head>
                <title>WEKO3</title>
            </head>
            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-10">
                            <h1><i class="fa fa-flash"></i>Permission required</h1>
                            <p>You do not have sufficient permissions to view this page.</p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
        ```

- APIの処理の流れ
    - アイテムタイプ一覧を取得する。
    - アイテムタイプが1件も存在しない場合はエラー画面（[error.html](https://github.com/RCOSDP/weko/blob/develop_v2.0.0/modules/weko-itemtypes-ui/weko_itemtypes_ui/templates/weko_itemtypes_ui/admin/error.html)）を表示する。
    - 指定されたアイテムタイプIDが存在しない場合は、アイテムタイプ一覧の先頭のIDにリダイレクトする（HTTP 302）。
    - アイテムタイプのスキーマ情報やフォーム情報、メタデータ項目リストなどを取得し、画面表示用に整形する。
    - システム管理者権限の有無を判定する。
    - マッピング種別やマッピング情報、スキーマ情報を取得し、画面表示用に整形する。
    - スキーマ情報は「[4. 全スキーマ一覧取得API](#4-全マッピング用スキーマ情報取得)」や「[5. 指定スキーマ取得API](#5-指定スキーマ名のマッピング用スキーマ情報取得)」で取得する。
    - 取得した情報をもとにマッピング画面（[create_mapping.html](https://github.com/RCOSDP/weko/blob/develop_v2.0.0/modules/weko-itemtypes-ui/weko_itemtypes_ui/templates/weko_itemtypes_ui/admin/create_mapping.html)）を描画・返却する。
    - リポジトリ管理者がアクセスした場合は、「システムが付与したアイテムタイプ  (親)」 の「Schema（親）」項目が非活性になる。
    - 例外発生時は400エラーを返す。
    - 権限のないロールでアクセスした場合は403エラーを返す。

## 3. アイテムタイプマッピング登録・更新

### POST /admin/itemtypes/mapping

#### 概要
アイテムタイプのマッピング情報を登録・更新する。

#### 処理概要

- リクエスト
    ```shell
    curl -X POST "http://<WEKO3のURL>/admin/itemtypes/mapping" \
        -H "Content-Type: application/json" \
        -b <cookie情報> \
        -d '{
            "item_type_id": <item_type_id>,
            "mapping_type": <SchemaName>,
            "mapping": {
                "field1": "value1",
                "field2": "value2"
            }
        }'
    ```
    - -H オプション

        Content-Typeはapplication/jsonを指定する

    - -b オプション

        ログインページによるログインで得たcookie情報を指定する

    - -d オプション

        リクエストボディを指定する

- レスポンス

    - [200] 正常登録
        ```json
        {
            "msg": "Successfully saved new mapping."
        }
        ```

    - [200] マッピング重複
        ```json
        {
            "duplicate": true,
            "err_items": ["field1", "field2"],
            "msg": "Duplicate mapping as below"
        }
        ```

    - [200] Content-Type不正
        ```json
        {
            "msg": "Header Error"
        }
        ```

    - [200] 予期せぬエラー
        ```json
        {
            "msg": "Unexpected error occurred."
        }
        ```

    - [403] 権限エラー
        ```html
        <!DOCTYPE html>
        <html>
            <head>
                <title>WEKO3</title>
            </head>
            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-10">
                            <h1><i class="fa fa-flash"></i>Permission required</h1>
                            <p>You do not have sufficient permissions to view this page.</p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
        ```

- APIの処理の流れ
    - Content-Typeがapplication/jsonであることを確認する。不正な場合は「Header Error」を返す。
    - リクエストボディからitem_type_id、mapping_type、mappingを取得する。
    - 指定されたitem_type_idに対応するアイテムタイプ情報を取得する。
    - マッピングの重複チェックを行い、重複があれば「duplicate: true」とエラー内容を返す。
    - 重複がなければ、マッピング情報を新規作成または更新し、DBへコミットする。
    - 操作ログ（UserActivityLogger）を記録する。
    - 例外発生時はロールバックし、「Unexpected error occurred.」を返す。
    - 正常終了時は「Successfully saved new mapping.」というメッセージを返す。

## 4. 全マッピング用スキーマ情報取得

### GET /admin/itemtypes/mapping/schema

#### 概要
全てのマッピング用スキーマ情報を取得。

#### 処理概要

- リクエスト
    ```shell
    curl -X GET "http://<WEKO3のURL>/admin/itemtypes/mapping/schema" -b <cookie情報>
    ```
    - -b オプション

        ログインページによるログインで得たcookie情報を指定する

- レスポンス
    - [200] 正常に取得
        ```json
        {
            "ddi_mapping": {},
            "jpcoar_mapping": {},
            "jpcoar_v1_mapping": {},
            "lom_mapping": {},
            "oai_dc_mapping": {}
        }
        ```

    - [403] 権限エラー
        ```html
        <!DOCTYPE html>
        <html>
            <head>
                <title>WEKO3</title>
            </head>
            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-10">
                            <h1><i class="fa fa-flash"></i>Permission required</h1>
                            <p>You do not have sufficient permissions to view this page.</p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
        ```

    - [500] サーバー内部エラー
        ```html
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
        <title>WEKO3</title>
        <h1>Internal Server Error</h1>
        <p>The server encountered an internal error and was unable to complete your request.</p>
        ```

- APIの処理の流れ
    - WekoSchemaから全てのスキーマ情報を取得する。
    - 各スキーマの内容（JSON）を辞書形式でまとめる。
    - スキーマ名のプレフィックスを除去する（remove_xsd_prefix）。
    - 取得したスキーマ情報をJSON形式で返却する。
    - 例外発生時は500エラーを返す。
    - 権限のないロールでアクセスした場合は403エラーを返す。


## 5. 指定スキーマ名のマッピング用スキーマ情報取得

### GET /admin/itemtypes/mapping/schema/\<SchemaName\>

#### 概要
指定したスキーマ名のマッピング用スキーマ情報を取得。

#### 処理概要
- パスパラメータ
    | パラメータ名 | 型     | 必須 | 説明         |
    |--------------|--------|------|--------------|
    | SchemaName   | string | ○    | スキーマ名   |

- リクエスト
    ```shell
    curl -X GET "http://<WEKO3のURL>/admin/itemtypes/mapping/schema/<SchemaName>" -b <cookie情報>
    ```
    - -b オプション

        ログインページによるログインで得たcookie情報を指定する

- レスポンス

    - [200] 正常に取得
        ```json
        {
            "jpcoar_mapping": {
                "accessRights": {},
                "alternative": {},
                // 省略
            }
        }
        ```

    - [403] 権限エラー
        ```html
        <!DOCTYPE html>
        <html>
            <head>
                <title>WEKO3</title>
            </head>
            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-10">
                            <h1><i class="fa fa-flash"></i>Permission required</h1>
                            <p>You do not have sufficient permissions to view this page.</p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
        ```

    - [500] サーバー内部エラー
        ```html
        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
        <title>WEKO3</title>
        <h1>Internal Server Error</h1>
        <p>The server encountered an internal error and was unable to complete your request.</p>
        ```

- APIの処理の流れ
    - WekoSchemaから指定されたスキーマ名に該当するスキーマ情報を取得する。
    - スキーマが存在する場合は、その内容（JSON）を辞書形式でまとめる。
    - スキーマ名のプレフィックスを除去する（remove_xsd_prefix）。
    - 取得したスキーマ情報をJSON形式で返却する。
    - 例外発生時は500エラーを返す。
    - 権限のないロールでアクセスした場合は403エラーを返す。

---

#### 更新履歴

| 日付         | GitHubコミットID | 更新内容   |
|--------------|------------------|------------|
| 2025/12/25   |                  | 初版作成   |
