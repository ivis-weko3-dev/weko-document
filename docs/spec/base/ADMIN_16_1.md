# プロフィール設定編集機能

## 目的・用途

本機能は、管理者としてプロフィール画面に表示される項目の設定を行う機能である

## 利用方法

【Administration\>アドバンスド（Advanced）\>プロフィール設定編集（Profile Settings）】の順でプロフィール設定編集画面に遷移し、プロフィール項目設定を編集し画面最下部下にある\[Save\]ボタンを押下することで設定を反映させる。

  - > 利用可能なロール

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
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

  - > 機能内容

1\.使用している画面

   - 【Administration\>アドバンスド（Advanced）\>プロフィール設定編集（Profile Settings）】：プロフィール画面に表示するフィールドの設定を行う画面


2\. 項目設定の設定・編集する

  - > 項目の要素について
  
      - ラベル名：プロフィール画面に表示される項目の見出しを入力

      - 入力方法："text","select","identifier","position(other)","phonenumber"の5種類から選択する

      - 表示設定：チェックボックスにチェックを入れることでプロフィール画面に表示される、チェックを外すことで項目を非表示状態にできる。

      - オプション：入力方法でselectを選択した場合にのみ表示されるテキストフィールド。|(パイプ)を挟んで区切ることで、selectの選択肢を作成する。

3\.表示項目一覧

       - > fullname項目
          - 初期ラベル名：氏名
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > university項目
          - 初期ラベル名：大学・機関
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：Professor|Assistant Professor|Full-time Instructor|Assistant Teacher|Full-time Researcher|Others (Input Detail)|JSPS Research Fellowship for Young Scientists (PD, SPD etc.)|JSPS Research Fellowship for Young Scientists (DC1, DC2)|Doctoral Course (Doctoral Program)|Master Course (Master Program)|Fellow Researcher|Listener|Student|

       - > department項目
          - 初期ラベル名：所属部局・部署
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > position項目
          - 初期ラベル名：役職
          - 初期入力方法：select
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item1項目
          - 初期ラベル名：役職（その他）
          - 初期入力方法：otherPosition
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item2項目
          - 初期ラベル名：電話番号
          - 初期入力方法：identifier
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item3項目
          - 初期ラベル名：所属学会名
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item4項目
          - 初期ラベル名：所属学会役職
          - 初期入力方法：select
          - 初期表示設定；True
          - 初期オプション：Member|Committee member|Director/Officer|President
      
       - > item5項目
          - 初期ラベル名：所属学会名
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item6項目
          - 初期ラベル名：所属学会役職
          - 初期入力方法：select
          - 初期表示設定；True
          - 初期オプション：Member|Committee member|Director/Officer|President

       - > item7項目
          - 初期ラベル名：所属学会名
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item8項目
          - 初期ラベル名：所属学会役職
          - 初期入力方法：select
          - 初期表示設定；True
          - 初期オプション：Member|Committee member|Director/Officer|President

       - > item9項目
          - 初期ラベル名：所属学会名
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item10項目
          - 初期ラベル名：所属学会役職
          - 初期入力方法：select
          - 初期表示設定；True
          - 初期オプション：Member|Committee member|Director/Officer|President

       - > item11項目
          - 初期ラベル名：所属学会名
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item12項目
          - 初期ラベル名：所属学会役職
          - 初期入力方法：select
          - 初期表示設定；True
          - 初期オプション：Member|Committee member|Director/Officer|President

       - > item13項目
          - 初期ラベル名：item13
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item14項目
          - 初期ラベル名：item14
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item15項目
          - 初期ラベル名：item15
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

       - > item16項目
          - 初期ラベル名：item16
          - 初期入力方法：text
          - 初期表示設定；True
          - 初期オプション：空文字

  -  入力を終えたら、最下部の左下に配置されているSAVEボタンを押下。

保存が完了した場合最上部に「Settings updated successfully」というメッセージのモーダルウィンドウが表示される。

項目のラベル名を空文字の状態で保存した場合に最上部に「Failed to update settings.」というエラーメッセージが最上部にモーダルウィンドウが表示される。
  
項目のオプションを空文字の状態で保存した場合に最上部に「Failed to update settings.」というエラーメッセージが最上部にモーダルウィンドウが表示される。

4\.プロフィール設定編集機能ON
    下記パスに格納されているフラグをTrueに変更するとプロフィール設定編集機能をONにすることができる。初期値はFalseであり、機能はOFF状態となっている。

    パス：/root/weko/modules/weko-user-profiles/weko_user_profiles/config.py

    変数：WEKO_USERPROFILES_CUSTOMIZE_ENABLED

  
  <!-- end list -->

  - > 関連モジュール

  <!-- end list -->

  - > weko-admin

  <!-- end list -->

  - > 処理概要

  <!-- end list -->

> プロフィール入力フォームとその入力内容チェックは、以下で定義している。

  - > パス：  
    > <https://github.com/RCOSDP/weko/blob/main/modules/weko-admin/weko_admin/views.py>
    > <https://github.com/RCOSDP/weko/tree/main/modules/weko-admin/weko_admin/static/js/weko_admin/user-profile-settings.js>

  - > このJavaScriptファイルは、Reactを使用してプロフィール入力フォームを管理し、ユーザーが入力した内容をサーバーに送信するためのもの。

> SAVEボタンがクリックされたときにエラーチェックを行い、AJAXリクエストを使用してURL「/api/admin/profile_settings/save」にデータを送信する。

  - > これによって、weko\_admin\_views.send_profile_settings_saveメソッドが呼び出され、プロフィール項目設定を更新する。

> プロフィールの設定は、admin\_settingsテーブルにJsonデータとして保存される。

  - > 更新履歴

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
<p>2024/10/18</p>
</blockquote></td>
<td>0bd5306557f56f25887b5e159db723457c09e8a2</td>
<td>初版作成</td>
</tr>
</tbody>
</table>