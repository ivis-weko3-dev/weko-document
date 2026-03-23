### CAPTCHA

- 目的・用途

本機能はリクエスト機能を用いてメールを送信時などに用いられるCAPTCHA（画像認証）機能を提供するAPIである。

- 利用方法

  - サンプルコード

    - CAPTCHA画像取得API

      curl <WEKO3のURL>/api/v1/captcha/image

    - CAPTCHA結果検証API

      curl -X POST -H "Content-Type: application/json" <WEKO3のURL>/api/v1/captcha/validate -d '{ "key": "aaa", "calculation_result": 20 }'

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

  1. CAPTCHA画像取得API

     - CAPTCHA画像を取得する。

  2. CAPTCHA認証API

     - CAPTCHAの計算結果を検証、計算結果が正しい場合に認証トークンを生成する。

- 関連モジュール

  - weko_records_ui/captcha.py
  - weko_records_ui/api.py

- 処理概要

    1. CAPTCHA画像取得API
       - サーバー負荷軽減のためリクエストのアクセス制限機能をかける。

       - リクエスト
         - API仕様書を参照
       - レスポンス
         - API仕様書を参照

       - APIの処理の流れ
         - CAPTCHA画像の生成を行う。
         - CAPTCHA画像の計算結果をRedisに保存する。
           - キー値は、画像生成日時とランダムなソルト値を組み合わせハッシュ化した値
         - 認証トークンを発行し、Redisに保存する。
           - 認証トークンは64文字のハッシュ値
         - 設定値により、Redisの有効期限を設定する。
         - レスポンスに設定するTTL値はRedisの有効期限より小さい値を設定する

    2. CAPTCHA認証API
       - サーバー負荷軽減のためリクエストのアクセス制限機能をかける。

       - リクエスト
         - API仕様書を参照
       - レスポンス
         - API仕様書を参照

       - APIの処理の流れ
         - CAPTCHAの計算結果を照合する。
           - 計算結果が異なる場合は400エラー。
         - 計算結果が正しい場合、Redisに格納されている認証トークンを返す。
           - 計算結果が間違っている場合、該当キーに登録されたRedisの情報を削除する。
         - 設定値により、Redisの有効期限を再設定する。
           - 設定値は、「CAPTCHA画像取得API」 で利用している設定値と同じ値を利用する。


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
