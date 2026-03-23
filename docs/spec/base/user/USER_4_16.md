### Item Registration：コンテンツ未登録時の制限公開機能

- 目的・用途

コンテンツ未登録時の利用申請方法を設定する。

- 利用方法

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
<td>※</td>
<td></td>
</tr>
</tbody>
</table>

※一般ユーザーは、ロールとして利用可能に設定することはできないが、個別のユーザーをAction Userとして設定することはできる。

- 前提条件

  - なし

- 機能内容

  - Item Registration画面にて、「利用申請を設定」チェックボックスにチェックを付けることで、コンテンツ未登録状態での利用申請方法が表示される。

  - 表示されたドロップダウンリストから利用申請方法を設定することができる。

  - 利用申請が設定されており、かつコンテンツファイルが登録されている場合、エラーメッセージを表示して次のアクションには進めない。

    - エラーメッセージ: 「Request Email Addresses do not exist.」

  - アイテムの利用申請方法は、承認者が承認をした時点から有効となる。

- 関連モジュール

- weko_items_ui

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
