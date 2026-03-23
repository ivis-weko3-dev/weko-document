### リクエストメール送信API

- 目的・用途

本機能はアイテムに紐づくリクエスト送信先に、リクエストメールを送信するAPIである。

- 利用方法

  - サンプルコード

    curl -X POST -H "Content-Type: application/json" <WEKO3のURL>/api/v1/records/1/request-mail \  
    -d '{ "from": "contributor@example.org", \  
    "subject": "About request mail", \  
    "message": "this is message of request mail.", \  
    "key": "aaa", \  
    "authorization_token": "68680b0b249e005b2d422393a17a9a3373ab6320d0d1af4d443336c0854602d8" }'

- 利用可能なロール

<table>
<thead>
<tr class="header">
<th>ロール</th>
<th>システム<br />
管理者</th>
<th>リポジトリ<br />
管理者</th>
<th>コミュニティ<br />
管理者</th>
<th>登録ユーザー</th>
<th>一般ユーザー</th>
<th>ゲスト<br />
(未ログイン)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>利用可否</td>
<td>○</td>
<td>○</td>
<td>○</td>
<td>○</td>
<td>○</td>
<td>○</td>
</tr>
</tbody>
</table>

- 機能内容

  - 指定したアイテムに紐づくリクエスト送信先に、リクエストメールを送信する。

- 関連モジュール

  - weko_records_ui/api.py

- 処理概要

  - サーバー負荷軽減のためリクエストのアクセス制限機能をかける。

  - リクエスト
    - API仕様書を参照

  - レスポンス
    - API仕様書を参照

  - APIの処理の流れ

    - レコードIDからリクエスト送信先を取得する(get_mail_list_by_item_id)。

      - リクエスト送信先が1件もない場合は404エラー。

    - 認証トークンを照合する。

      - 認証トークンの値が異なる場合は401エラー。

    - 入力された送信元のメールアドレスのバリデーションチェック。

    - 入力情報を元にリクエスト送信先にメールを送信する。

      - メールの送信元をCcに設定し、併せてメールが送信される。

- 更新履歴

<table>
<thead>
<tr class="header">
<th>日付</th>
<th>GitHubコミットID</th>
<th>更新内容</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><blockquote>
<p>2025/10/10</p>
</blockquote></td>
<td></td>
<td>初版作成</td>
</tr>
</tbody>
</table>