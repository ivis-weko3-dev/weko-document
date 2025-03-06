
# 一括エクスポート

## 目的・用途

本機能は、管理者として、アイテムの全件エクスポートを行う機能である。

## 利用方法

管理者は ```Administration→アイテム管理(Items)→一括エクスポート(Bulk Export)画面``` を開き、アイテムの全件エクスポートを行う。

## 利用可能なロール

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
<td>〇</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

## 機能内容

<!-- end list -->

  - Filter：一括出力するアイテムを制限する。(v0.9.22)
    
      - 一括出力するアイテムをアイテムタイプにより制限することができる。ALLを選択した場合はすべてのアイテムタイプを出力する。
    
      - 一括出力するアイテムをアイテムIDにより制限することができる。
        
          - 全件。 何も入力していない場合。 （デフォルト）
        
          - 単一のアイテムID。 例： 50
        
          - アイテムID範囲。 例： 10‐100
        
          - あるアイテムID以後。 例： 10‐
        
          - あるアイテムID以前。 例： ‐10
    
      - 出力の結果は選択したアイテムタイプと入力したアイテムIDの積集合。 デフォルトは全件出力。
    
      - 違うユーザーが違う条件で一緒に出力可能。ダウンロードURLが同じであるが、各ユーザーが設定した条件のエクスポートが可能。
    
      - 一人のユーザーが同時に出力できる条件は一つのみである。完了しない限り、次の出力はできない。

  - the last item ID: 最も新しく作られたアイテムIDを表示する。(v0.9.2)

  - 「エクスポート」（Export）ボタン  
    Exportボタンを押すと、全件出力を実行してよいかの確認ダイアログを表示する。確認ダイアログで実行/キャンセルを選択する。
    
      - 「Execute」ボタン
        
          - 「実行」ボタンを押すと、確認用ダイアログを閉じてアイテムの全件エクスポートを行う。
        
          - 実行後はダウンロードのURLを画面上に表示する。
        
          - URLをクリックするとzipファイル(export-all.zip)をダウンロードする。  
            なお、このzipファイルにコンテンツファイルは含まれていない。
        
          - 他のユーザーがエクスポート実行中の場合、Exportボタンを非活性化する。
        
          - Celeryが起動していない場合は「実行」ボタンを非活性化する．「Celery is not running.」のエラーメッセージを表示する．(v0.9.22)
    
      - 「キャンセル」ボタン
        
          - 「キャンセル」ボタンを押すと、アイテムの全件エクスポートを行なわず、確認用ダイアログを閉じる。

  - 「キャンセル」（Cancel）ボタン  
    初期状態は非活性とし、Exportを実行している時に活性とする。  
    Exportを実行している時に、キャンセルボタンを押すと、Export処理のキャンセルを行う。  
    ボタンを押すと、全件エクスポートの処理をキャンセルしてよいかの確認ダイアログを表示する。
    
      - 「実行」ボタン
        
          - 「実行」ボタンを押すと、アイテムの全件エクスポートを行なわず、確認用ダイアログを閉じる。
    
      - 「キャンセル」ボタン
        
          - 「キャンセル」ボタンを押すと、全件エクスポート処理のキャンセルを行わず、確認用ダイアログを閉じる。

  - Status：一括エクスポートの状態を表示する。

      - 表示なし：一括エクスポート実行前、待機中
      - STARTED：一括エクスポート開始、実行中
      - SUCCESS：一括エクスポート完了
      - REVOKED：一括エクスポートキャンセル

  - Export Start Time：一括エクスポートの開始時刻を表示。フォーマットは「YYYY/MM/DD HH:MM:SS」

  - Export Finish Time：一括エクスポートの終了時刻を表示。フォーマットは「YYYY/MM/DD HH:MM:SS」

  - Download URL：一括エクスポート完了後に表示されるURL。クリックするとエクスポートしたデータのダウンロードができる。


## 関連モジュール

  - weko_search_ui
  - weko_admin
  - invenio_files_rest:ダウンロードファイル生成のみに使用

## 処理概要


  - 一括出力（一括エクスポート）画面表示時に以下の処理が行われる。
    
      - weko_search_ui.admin.ItemBulkExport.Indexメソッドが呼び出され画面を表示する。
    
      - weko_search_ui.static.js.weko_search_ui.export.getLastItemIdメソッドによってget_last_item_idメソッドが呼び出され、一番大きなキーidを取得する。
    
      - weko_search_ui.static.js.weko_search_ui.export.getListItemTypeメソッドによってget_itemtypesが呼び出され、アイテムタイプのリストを取得し、json形式にして取得する。

> これらの取得した情報から一括出力画面を表示する。

  - 一括出力（一括エクスポート）画面

      - 一括出力画面を表示している間、３秒ごとにweko_search_ui.static.js.weko_search_ui.export.checkExportStatusメソッドが呼び出され以下の処理が行われる。

        - check_export_statusメソッドを呼び出す。
        - check_export_statusメソッドからcheck_celery_is_runメソッドを呼び出してCeleryが起動しているかのチェックを行う。
        - check_export_statusメソッドから、get_export_statusメソッドを呼び出して以下の処理を行う。

          - Redisのキャッシュからエクスポートタスクの情報を取得する。
          - タスクIDが存在する場合、エクスポートタスクの情報を用いてcheck_write_file_infoメソッドを用いてエクスポート処理の進行状況を取得する。
          - エクスポートタスクが終了していたら、エクスポートされたデータを処理し、ZIPアーカイブとして保存し、そのファイルのURIを取得してキャッシュに保存する。
          - export_status、ダウンロードURIの有無、Celeryの実行状態、エラーメッセージ、エクスポート実行メッセージ、ステータス、開始時刻、終了時刻をJSON形式で返却し、画面に反映する。
    
      - celeryが起動していない場合は「エクスポート」ボタンを不活性化する。
    
      - アイテムタイプのプルダウンからアイテムタイプを選択すると、そのアイテムタイプに属するアイテムをエクスポート対象になるようweko_search_ui.static.js.weko_search_ui.export.SelectItemChangeメソッドで設定する。
    
      - アイテムIDの入力欄に数字を入力すると出力するアイテムIDをweko_search_ui.static.js.weko_search_ui.export.InputItemIdChangeメソッドで制限する。
    
      - 「エクスポート」ボタンを押し、更にポップアップの「Execute」ボタンを押下する。その場合、weko_search_ui.static.js.weko_search_ui.export.handleExportメソッドが呼び出され以下の処理が行われる。
      
        - export_allメソッドが呼び出される。
        - export_allメソッドからget_export_statusメソッドを呼び出して以下の処理を行う。
        
          - Redisのキャッシュからエクスポートタスクの情報を取得する。
          - タスクIDが存在する場合、それを用いてcheck_write_file_infoメソッドを用いてエクスポート処理の進行状況を取得する。
          - エクスポートステータスをexport_allメソッドの処理に返却する。
        
        - エクスポート開始時刻の記録をする。
        - エクスポートステータスがFalseの時、export_all_taskメソッドを非同期で呼び出して、export_all_taskメソッドからweko-search-uiのutils.pyのexport_allメソッドを以下の処理を行う。
        
          - エクスポート対象のアイテムタイプリストを取得する。
          - Redisのキャッシュのエクスポートタスクの情報をリセットする。
          - エクスポート対象のアイテムIDの範囲を設定する。
          - _get_export_dataメソッドを呼び出して以下の処理を行う。
          
            - エクスポート処理の進行状況を管理するオブジェクトを作成し、Redisのキャッシュに保存する。
            - アイテムタイプ毎に、エクスポートするアイテムのデータを収集し、ファイルに書き込む。
            - レコードIDをデータベースから取得し、レコードIDをリストに格納し、リストをループして各レコードのデータを収集する。
            - configで設定しているWEKO_SEARCH_UI_BULK_EXPORT_LIMITの数値毎に、エクスポートファイルを作成する。
            - write_files_taskメソッドを呼び出して以下の処理を行う
            
              - エクスポート処理の進行状況をRedisキャッシュに更新する。
              - エクスポートするデータを取得する。
              - Redisキャッシュにある進行状況を確認してキャンセルフラグが無ければ、write_filesメソッドを呼び出してエクスポートファイルにエクスポートデータの書き込みとRedisキャッシュの更新を行う。

            - write_filesメソッドの結果に基づいてエクスポート処理のステータスを更新する。
          
        - 再度get_export_statusメソッドを呼び出してステータスの取得を行い、export_status、ダウンロードURIの有無、Celeryの実行状態、エラーメッセージ、エクスポート実行メッセージ、ステータス、開始時刻、終了時刻をJSON形式で返却し、画面に反映する。

      - export_statusがtrueの場合は「エクスポート」ボタンを不活性化、「キャンセル」ボタンを活性化する。

      - export_statusがfalseの場合は「エクスポート」ボタンを活性化、「キャンセル」ボタンを不活性化する。
        
      - エクスポートして、URLが表示されるまでの間に、「キャンセル」ボタンを押し、「Execute」ボタンを押す。その場合、weko_search_ui.static.js.weko_search_ui.handleCancelメソッドが呼び出され以下の処理を行う。
      
        - cancel_exportメソッドを呼び出して、cancel_exportメソッドからcancel_export_allメソッドを呼び出して以下の処理を行う。

          - task_idをRedisのキャッシュから取得する。
          - celery.task.controlのrevokeメソッドを呼び出して、task_idのエクスポートタスクをキャンセルする。
          - delete_task_id_cacheを非同期で呼び出して、指定された時間後にタスクIDをキャッシュから削除する。
          - ファイル作成メッセージのキャンセルフラグをTrueに設定し、Redisキャッシュを更新する。
          
        - get_export_statusメソッドを呼び出してステータスを取得する。
        - キャンセルの結果、export_statusをfalse、およびステータスをJSON形式で返却し、画面に反映する。ダウンロードURLの生成、表示をキャンセルする。
    
      - 画面上に表示されたダウンロードURLを押下する。その場合、weko_search_ui.admin.ItemBulkExport.export_allメソッドにて、 FileInstance.get_by_uriメソッドが呼び出され、ダウンロードファイルを生成し、ダウンロードする。なお、ダウンロードされるファイル形式はzipであり、アイテムのメタデータについてのファイルはtsv形式である。
    
      - 一括エクスポートはHide項目も含めて出力する。(メタデータプロパティがHideのものも表示する。)
    
      - エクスポート中にcheck_celery_is_runメソッド、get_export_statusメソッドでエクスポートに必要な情報がとれない場合、ダウンロードURLは表示されない。

  - エクスポート処理実行時、テンポラリディレクトリのファイル名を以下のように設定する。
    
      - > /home/invenio/.virtualenvs/invenio/var/instance/data/tmp/weko_export_xxxxxxxx

  - 以下の変数はweko_admin.configで設定されている。
    
      - > 一括エクスポートはアイテムタイプ単位で出力する．1ファイルあたりの出力件数は　WEKO_SEARCH_UI_BULK_EXPORT_LIMIT　で設定する．(v0.9.22)
    
      - > 一括エクスポート中にエラーが発生した場合は，WEKO_SEARCH_UI_BULK_EXPORT_RETRYに指定された回数リトライする．(v0.9.22)

      - WEKO_ADMIN_CACHE_PREFIX : REDISキーフォーマット

  - 以下の変数はweko_search_ui.configで設定されている。

      - WEKO_SEARCH_UI_BULK_EXPORT_EXPIRED_TIME：一括エクスポートされたファイルのURLの有効期限(分)

      - Redisキャッシュキー

          - WEKO_SEARCH_UI_BULK_EXPORT_TASK：一括エクスポート処理のメッセージを保存するためのキー

          - WEKO_SEARCH_UI_BULK_EXPORT_RUN_MSG：一括エクスポート処理が実行中であることを示すメッセージを保存するためのキー

          - WEKO_SEARCH_UI_BULK_EXPORT_FILE_CREATE_RUN_MSG：一括エクスポート処理中に作成されたファイルに関する情報を保存するためのキー

          - WEKO_SEARCH_UI_BULK_EXPORT_TASK：一括エクスポートタスクのIDを保存するためのキー

          - WEKO_SEARCH_UI_BULK_EXPORT_URI：一括エクスポートされたファイルのURIを保存するためのキー

      - WEKO_SEARCH_DEFAULT_TIMEZONE：一括エクスポート開始時刻/終了時刻のタイムゾーン

##



## 更新履歴


|日付|GitHubコミットID|更新内容|
|---|---|---|
|2023/08/31|353ba1deb094af5056a58bb40f07596b8e95a562|初版作成|
|2025/03/03|a5a77e8aa2693cf9be7cb6828a07c9237c6e9780|v1.1.0対応|
