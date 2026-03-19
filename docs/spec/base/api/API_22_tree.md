# インデックスツリー操作API
## インデックスツリー取得API
### 目的・用途

階層情報をもつインデックス一覧を取得するAPI

### 利用方法

以下のAPIを実行する
```shell
curl -X GET <WEKO3のURL>/api/tree?action=<アクション>&c=<コミュニティID>&more_ids=<追加表示対象のインデックスIDリスト>
```

### 利用可能なロール

|ロール|システム<br>管理者|リポジトリ<br>管理者|コミュニティ<br>管理者|登録ユーザー|一般ユーザー|ゲスト<br>(未ログイン)|
|---|---|---|---|---|---|--|
|利用可否|○|○|○|○|○|○|

### 機能内容

- インデックスの一覧を階層情報を含めて取得する

### 関連モジュール

- weko_index_tree

### 処理概要

- API:
    - modules/weko-index-tree/weko_index_tree/rest.py::IndexTreeActionResource

1. クエリパラメータより、アクション、コミュニティID、追加表示対象のインデックスIDリストを取得する。
1. 取得したアクション、コミュニティID、追加表示対象のインデックスIDリストの値に応じて、以下の処理を行う。
    1. アクションに browsing が含まれ、コミュニティIDと追加表示対象のインデックスIDリストに値が設定されておらず、ログインしている場合
        * Redis または DB より表示対象のインデックスツリー情報を取得する。
    1. アクションに browsing が含まれ、コミュニティIDと追加表示対象のインデックスIDリストに値が設定されておらず、ログインしていない場合
        * Redis または DB より初期表示状態のインデックスツリー情報を取得する。
    1. アクションに browsing が含まれ、コミュニティIDに値が設定されておらず、追加表示対象のインデックスIDリストに値が設定されている場合
        * DB より追加表示対象のインデックスに属するすべてのインデックスの情報を含むインデックスツリー情報を取得する。
    1. アクションに browsing が含まれ、コミュニティIDと合致するコミュニティが存在し、追加表示対象のインデックスIDリストに値が設定されていない場合
        * DB より指定したコミュニティが所有するインデックス配下のインデックスツリー情報を取得する。
    1. アクションに browsing が含まれ、コミュニティIDと合致するコミュニティが存在し、追加表示対象のインデックスIDリストに値が設定されている場合
        * DB より指定したコミュニティが所有するインデックス配下で、追加表示対象のインデックスに属するすべてのインデックスの情報を含むインデックスツリー情報を取得する。
    1. アクションに値が設定されていないまたは browsing が含まれておらず、システム管理者またはリポジトリ管理者の場合
        * DB よりすべてのインデックスツリー情報を取得する。
    1. アクションに値が設定されていないまたは browsing が含まれておらず、システム管理者やリポジトリ管理者でないユーザーの場合
        * DB より所属するコミュニティが閲覧可能なインデックスツリー情報を取得する。
1. 取得したインデックスツリー情報を返却する。

## インデックス取得API
### 目的・用途

指定したインデックスに設定した情報を取得する

### 利用方法

以下のAPIを実行する
```shell
curl -X GET <WEKO3のURL>/api/tree/index/<index_id>
```

### 利用可能なロール

|ロール|システム<br>管理者|リポジトリ<br>管理者|コミュニティ<br>管理者|登録ユーザー|一般ユーザー|ゲスト<br>(未ログイン)|
|---|---|---|---|---|---|--|
|利用可否|○|○|○|※|※|※|

※公開状態のインデックスに対してのみ使用可能

### 機能内容

- 指定したインデックスに設定されている情報を取得する

### 関連モジュール

- weko_index_tree

### 処理概要

- API:
    - modules/weko-index-tree/weko_index_tree/rest.py::IndexActionResource

1. index_id が "0"でない場合、以下の処理を行う。
    1. 権限情報を含めた指定のインデックス情報を取得する。
    1. 子インデックスがあるかどうかを確認し、ある場合はインデックス情報に子インデックス存在フラグをたてる。
    ない場合は追加検索フラグをおろす。
1. 以下の条件に従い、指定したインデックスに対して編集権限を有しているか確認する。
    1. 実行者がシステム管理者、リポジトリ管理者である場合、無条件で編集権限を有する。
    1. 実行者がコミュニティ管理者かつ指定したインデックスがコミュニティで管理しているインデックスに属している場合、編集権限を有する。
1. 編集権限フラグをインデックス情報に設定する。
1. 取得したインデックス情報を返却する。

## インデックス新規作成API
### 目的・用途

インデックスを新たに作成する

### 利用方法

以下のAPIを実行する
```shell
curl -X POST <WEKO3のURL>/api/tree/index/<index_id> -h "Cookie: session=<セッション情報>" -h "Content-Type: application/json" -d '{"id": 1234567890123, "value": "New Index"}'
```

### 利用可能なロール

|ロール|システム<br>管理者|リポジトリ<br>管理者|コミュニティ<br>管理者|登録ユーザー|一般ユーザー|ゲスト<br>(未ログイン)|
|---|---|---|---|---|---|--|
|利用可否|○|○|○|×|×|×|

### 機能内容

- 指定したインデックスに対し、子要素として新たにインデックスを作成する

### 関連モジュール

- weko_index_tree

### 処理概要

- API
    - modules/weko-index-tree/weko_index_tree/rest.py::IndexActionResource

1. リクエストより登録するインデックス情報を取得する。  
取得できなかった場合はエラー終了とする。
1. 指定したインデックスがロックされている場合、ロックされている旨のエラーメッセージを返却する。
1. 以下の情報でインデックスを作成する。
    * id: リクエストデータのid
    * parent: パスにて指定したindex_id
    * index_name: リクエストデータのvalue
    * index_name_english: リクエストデータのvalue
    * index_link_name_english: index_name_englishにて指定した値
    * owner_user_id: ログインユーザーのid
    * browsing_role: 「jc_」で始まるロールは`WEKO_INDEXTREE_GAKUNIN_GROUP_DEFAULT_BROWSING_PERMISSION`がTrueの場合のみ、それ以外のロールはすべて追加(id)
    * contribute_role: 「jc_」で始まるロールは`WEKO_INDEXTREE_GAKUNIN_GROUP_DEFAULT_CONTRIBUTE_PERMISSION`がTrueの場合のみ、それ以外のロールはすべて追加(id)
    * more_check: False
    * display_no: `WEKO_INDEX_TREE_DEFAULT_DISPLAY_NUMBER`の値
    * coverpage_state: False
    * recursive_coverpage_check: False
    * browsing_group: すべてのグループ(id)
    * contribute_group: すべてのグループ(id)

    `WEKO_HANDLE_ALLOW_REGISTER_CNRI`がTrueの場合は以下も設定する。
    * cnri: 発行されたハンドル
    * index_url: <WEKO3のURL>/search?search_type=2&q=<設定したid>

    パスで指定したindex_idが0の場合は以下の値を設定する。
    * position: 「Root Index」を親に持つインデックスのうちpositionの最大値+1

    パスで指定したindex_idが0でなく、存在するインデックスの場合以下を設定する。
    * position: 指定したインデックスのうちpositionの最大値+1
    * harvest_public_state: 親インデックスのharvest_public_state
    * display_format: 親インデックスのdisplay_format
    * 親インデックスのrecursive_public_stateがTrueの場合は以下も設定する。
        * public_state: 親インデックスのpublic_state
        * public_date: 親インデックスのpublic_date
        * recursive_public_state: 親インデックスのrecursive_public_state
    * 親インデックスのrecursive_browsing_roleがTrueの場合は以下も設定する。
        * browsing_role: 親インデックスのbrowsing_role
        * recursive_browsing_role: 親インデックスのrecursive_browsing_role
    * 親インデックスのrecursive_contribute_roleがTrueの場合は以下も設定する。
        * contribute_role: 親インデックスのcontribute_role
        * recursive_contribute_role: 親インデックスのrecursive_contribute_role
    * 親インデックスのrecursive_browsing_groupがTrueの場合は以下も設定する。
        * browsing_group: 親インデックスのbrowsing_group
        * recursive_browsing_group: 親インデックスのrecursive_browsing_group
    * 親インデックスのrecursive_contribute_groupがTrueの場合は以下も設定する。
        * contribute_group: 親インデックスのcontribute_group
        * recursive_contribute_group: 親インデックスのrecursive_contribute_group
1. インデックスの作成に失敗した場合、エラー終了とする。
1. 日本語の場合は日本語で、それ以外の言語の場合は英語でインデックスツリー情報を作成し、Redisに格納する。  
その後、不要となったツリーリセット情報を削除する。
1. 実行結果を返却する。

## インデックス更新API
### 目的・用途

対象のインデックス情報を更新する

### 利用方法

以下のAPIを実行する
```shell
curl -X PUT <WEKO3のURL>/api/tree/index/<index_id> -h "Cookie: session=<セッション情報>" -h "Content-Type: application/json" -d '{
    "biblio_flag": false,
    "browsing_group": {"allow": [], "deny": []},
    "browsing_role": {"allow": [{"id": 3, "name": "Contributor"}], "deny": []},
    "can_edit": true,
    "cnri": "",
    "comment": "",
    "contribute_group": {"allow": [], "deny": []},
    "contribute_role": {"allow": [], "deny": []},
    "coverpage_state": false,
    "display_format": "1",
    "display_no": 5,
    "harvest_public_state": true,
    "harvest_spec": "",
    "harvest_children": false,
    "id": 1234567890123,
    "image_name": "",
    "index_link_enabled": false,
    "index_link_name": "",
    "index_link_name_english": "New Index",
    "index_name": "New Index",
    "index_name_english": "New Index",
    "index_url": "",
    "is_deleted": false,
    "more_check": false,
    "online_issn": "",
    "owner_user_id": 1,
    "parent": 0,
    "position": 0,
    "public_date": "",
    "public_state": true,
    "recursive_browsing_group": false,
    "recursive_browsing_role": false,
    "recursive_contribute_group": false,
    "recursive_contribute_role": false,
    "recursive_coverpage_check": false,
    "recursive_public_state": false,
    "rss_status": false,
    "thumbnail_delete_flag": false
}'
```

### 利用可能なロール

|ロール|システム<br>管理者|リポジトリ<br>管理者|コミュニティ<br>管理者|登録ユーザー|一般ユーザー|ゲスト<br>(未ログイン)|
|---|---|---|---|---|---|--|
|利用可否|○|○|○|×|×|×|

### 機能内容

- 指定したインデックスに対し、渡された情報を用いて更新を行う

### 関連モジュール

- weko_index_tree

### 処理概要

- API
    - modules/weko-index-tree/weko_index_tree/rest.py::IndexActionResource

1. リクエストより更新するインデックス情報を取得する。  
取得できなかった場合はエラー終了とする。
1. アイテムインポートが実行中の場合、インポート実行中の旨のエラーメッセージを返却する。
1. 指定したインデックスがロックされている場合、以下の処理を行う。
    1. ロックされている旨のエラーメッセージを取得する。
1. インデックスの公開、ハーベスト公開のいずれかの設定が非公開であり、インデックス内にDOIが付与されたアイテムを含む場合、以下の処理を行う。
    1. インデックスの公開、ハーベスト公開の公開設定の状況に応じ、非公開にできない旨のエラーメッセージを取得する。
1. 指定したインデックスがロックされておらず、公開設定に問題がない場合、以下の処理を行う。
    1. サムネイルが削除されている場合、設定していたファイルを削除する。
    1. 渡されたリクエストの値を用いてインデックスを更新する。
    1. インデックスの更新に失敗した場合、エラー終了とする。
1. 日本語の場合は日本語で、それ以外の言語の場合は英語でインデックスツリー情報を作成し、Redisに格納する。  
その後、不要となったツリーリセット情報を削除する。
1. 実行結果を返却する。

## インデックス削除API
### 処理概要

対象のインデックスを削除する

### 利用方法

以下のAPIを実行する
```shell
curl -X DELETE <WEKO3のURL>/api/tree/index/<index_id>?action=<アクション> -h "Cookie: session=<セッション情報>"
```

### 利用可能なロール

|ロール|システム<br>管理者|リポジトリ<br>管理者|コミュニティ<br>管理者|登録ユーザー|一般ユーザー|ゲスト<br>(未ログイン)|
|---|---|---|---|---|---|--|
|利用可否|○|○|○|×|×|×|

### 機能内容

- 指定したインデックスを削除する

### 関連モジュール

- weko_index_tree

### 処理概要

- API
    - modules/weko-index-tree/weko_index_tree/rest.py::IndexActionResource

1. インデックスIDが指定されていない、または0以下である場合エラー終了とする。
1. アイテムインポートが実行中の場合、インポート実行中の旨のエラーメッセージを取得する。
1. アイテムインポートが実行されていない場合、以下の処理を行う。
    1. 指定したインデックスがロックされている場合、ロックされている旨のエラーメッセージを取得する。
    1. 指定したインデックスがロックされていない場合、以下の処理を行う。
        1. 指定したインデックスと子インデックスをロックする。
        1. 指定したインデックス内にDOIが付与されたアイテム、編集中のアイテムを含む場合、または指定したインデックスがハーベスト公開されている場合、各状態に応じたエラーメッセージを取得する。
    1. エラーメッセージの取得を一度もしていない場合、子インデックスを含め指定したインデックスを削除する。
1. 日本語の場合は日本語で、それ以外の言語の場合は英語でインデックスツリー情報を作成し、Redisに格納する。  
その後、不要となったツリーリセット情報を削除する。
1. 実行結果を返却する。
