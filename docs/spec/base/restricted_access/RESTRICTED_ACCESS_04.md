### メールテンプレート

※v0.9.22現在、未実装。今後リリースの予定

  - 使用している画面  
    【Admin \> Setting \> メールテンプレート】：自動送信メールのタイトル、文面を設定する画面である

  - 自動送信メールの内容を設定する

  - 【Admin \> Setting \> メールテンプレート】に送信元の情報を設定する
    
      - 「Mail Template」にてメール文面の設定をする
    
      - 送信者は「設定」-\[メール送信\]-\[Mail Setting\]で設定したユーザー

設定項目は以下の2つである

  - Subject：メールタイトル

  - (メール内容）：メール内容
  
上記2点は必須項目で、どちらか一方でも空だとエラーメッセージが表示される

#### メールテンプレート拡張機能

システム管理者は、環境設定ファイル(instance.cfg)に記された定数("INVENIO_MAIL_ADDITIONAL_RECIPIENTS_ENABLED")を編集することで、デフォルトでは無効化されている本機能を有効化することができる

本機能を有効化すると、メールテンプレート編集画面に以下の3つの項目が新たに表示されるようになる

  - Recipients：送信先（受信者）

  - CC

  - BCC

なお上記3項目についての入力の有無は任意である

これらの項目には以下の3つの制限事項が課される

  - 入力されるメールアドレスはWEKOシステム上に登録されているメールアドレスであること

  - 上記のメールアドレスに紐づくユーザーが無効化されていないこと

  - 複数のメールアドレスを登録する場合は、カンマ(,)を用いること

上記3点の条件が1つでも満たされない場合、エラーメッセージが表示される

メールテンプレート登録後にユーザーが削除・無効化された場合、「当該メールテンプレートの次回更新時」もしくは「当該メールテンプレートを用いたメール送信時」に検出される

  - 「当該メールテンプレートの次回更新時」の場合、通常の仕様と同じく、保存時に無効なアドレスとしてエラーメッセージが表示される

  - 「当該メールテンプレートを用いたメール送信時」の場合、送信前に自動的に当該メールテンプレートから対象ユーザーのメールアドレスが削除される

本機能を無効化した場合、以下の変更が適用される

  - メールテンプレート編集画面から「Recipients, CC, BCC」3つの項目が削除される

  - メール送信時、メールテンプレートに登録したメールアドレスにメールが送信されない

      - ただしデータベースにはデータが保持されたまま残るため、機能を再び有効化した場合は以前に登録したメールアドレスに送信されるようになる

デフォルトで以下のメールが設定されており、それぞれ制限公開機能で用いる自動送信メールに関係している

*① 非ログインユーザに利用申請ワークフローURLを送信する  
Subject: 利用申請登録のご案内／Register Application for Use  
本文:  
\[restricted\_site\_name\_ja\]です。  
下記のリンクにアクセスしていただき、利用申請の登録を行ってください。*

*\[url\_guest\_user\]*

*このメールは自動送信されているので返信しないでください。  
お問い合わせは下記までお願いします。また、このメールに心当たりのない方は、\[restricted\_site\_name\_ja\]までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*This is a message from \[restricted\_site\_name\_en\].  
Please access the link below and register your Application.*

*\[url\_guest\_user\]*

*Please do not reply to this email as it has been sent automatically.  
Please direct all inquiries to the following address.  
Also, if you received this message in error, please notify \[restricted\_site\_name\_en\].*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]  
E-mail：\[restricted\_site\_mail\]*

*② 利用者に対して、利用申請登録のリマインドを行う  
Subject: データ利用申請の受付のお知らせ／Your Application was Received  
本文:  
\[restricted\_institution\_name\_ja\]です。  
\[restricted\_site\_name\_ja\]をご利用いただいて、ありがとうございます。*

*下記の利用申請を受け付けました。*

*申請番号： \[restricted\_activity\_id\]  
登録者名： \[restricted\_fullname\]  
メールアドレス： \[restricted\_mail\_address\]  
所属機関：\[restricted\_university\_institution\]  
研究題目：\[restricted\_research\_title\]  
申請データ：\[restricted\_data\_name\]  
申請年月日：\[restricted\_application\_date\]*

*\[restricted\_institution\_name\_ja\]で審査しますので、結果の連絡をお待ちください。*

*このメールは自動送信されているので返信しないでください。  
お問い合わせは下記までお願いします。また、このメールに心当たりのない方は、\[restricted\_institution\_name\_ja\]までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*Dear \[restricted\_fullname\],*

*This is a message from \[restricted\_institution\_name\_en\].  
Thank you for using \[restricted\_site\_name\_en\].*

*We received the below application:*

*Application No.：\[restricted\_activity\_id\]  
Name：\[restricted\_fullname\]  
E-mail：\[restricted\_mail\_address\]  
Affiliation：\[restricted\_university\_institution\]  
Title of research：\[restricted\_research\_title\]  
Dataset requested ：\[restricted\_data\_name\]  
Application date：\[restricted\_application\_date\]*

*You will be notified once the application is approved.*

*Please do not reply to this email as it has been sent automatically.  
Please direct all inquiries to the following address.  
Also, if you received this message in error, please notify \[restricted\_institution\_name\_en\].*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]  
E-mail：\[restricted\_site\_mail\]*

*③ 承認者に対して、利用申請の承認の依頼を行う  
Subject: 利用申請の承認のお願い／Request for Approval of Application for Use  
本文:  
\[restricted\_site\_name\_ja\]です。下記の方から利用申請がありました。*

*申請番号： \[restricted\_activity\_id\]  
登録者名： \[restricted\_fullname\]  
メールアドレス： \[restricted\_mail\_address\]  
所属機関：\[restricted\_university\_institution\]  
研究題目：\[restricted\_research\_title\]  
申請データ：\[restricted\_data\_name\]  
申請年月日：\[restricted\_application\_date\]*

*\[restricted\_site\_name\_ja\]（\[restricted\_site\_url\]）にアクセスしていただき、画面左上からログインしていただけますと、「ワークフロー」タブが現れます。ここから上記の申請内容をご確認ください。「承認」または「却下」のボタンをクリックしてください。*

*このメールに心当たりのない方は、\[restricted\_site\_name\_ja\] までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*This is a message from \[restricted\_site\_name\_en\].  
We received the below application.*

*Application No.：\[restricted\_activity\_id\]  
Name：\[restricted\_fullname\]  
E-mail：\[restricted\_mail\_address\]  
Affiliation：\[restricted\_university\_institution\]  
Title of research：\[restricted\_research\_title\]  
Dataset requested ：\[restricted\_data\_name\]  
Application date：\[restricted\_application\_date\]*

*Please access \[restricted\_site\_name\_en\]（\[restricted\_site\_url\]） and log in from the upper left corner of the screen, and the \[Workflow\] tab will appear. From here, please confirm the above application by clicking on “approve” or “reject”.*

*If you received this message in error, please notify the \[restricted\_site\_name\_en\]*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]  
E-mail：\[restricted\_site\_mail\]*

*④ 申請者に対して、利用申請が承認されたことを伝え、ダウンロードリンクを送付する  
Subject: 利用申請の承認のお知らせ／Your application was approved  
本文:  
\[restricted\_site\_name\_ja\]です。*

*下記の利用申請を承認しました。*

*申請番号： \[restricted\_activity\_id\]  
登録者名： \[restricted\_fullname\]  
メールアドレス： \[restricted\_mail\_address\]  
所属機関：\[restricted\_university\_institution\]  
研究題目：\[restricted\_research\_title\]  
申請データ：\[restricted\_data\_name\]  
申請年月日：\[restricted\_application\_date\]*

*データは、下記アドレスよりダウンロードすることができます。*

*\[restricted\_download\_link\]*

*当日より\[restricted\_expiration\_date\]\[restricted\_expiration\_date\_ja\]日後まで有効です。ダウンロード期限を過ぎると、再申請が必要です。*

*このメールは自動送信されているので返信しないでください。  
このメールに心当たりのない方は、\[restricted\_site\_name\_ja\]までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*This is a message from \[restricted\_site\_name\_en\].  
Your application below has been approved.*

*Application No.：\[restricted\_activity\_id\]  
Name：\[restricted\_fullname\]  
E-mail：\[restricted\_mail\_address\]  
Affiliation：\[restricted\_university\_institution\]  
Title of research：\[restricted\_research\_title\]  
Dataset requested ：\[restricted\_data\_name\]  
Application date：\[restricted\_application\_date\]*

*The data can be downloaded from the address below.*

*\[restricted\_download\_link\]*

*It is valid from that day until the day after \[restricted\_expiration\_date\]\[restricted\_expiration\_date\_en\]. You will need to resubmit your application once the link becomes unavailable.*

*Please do not reply to this email as it has been sent automatically.  
If you received this message in error, please notify the \[restricted\_site\_name\_en\].*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]  
E-mail：\[restricted\_site\_mail\]*

*⑤ 申請者に対して、利用申請が却下されたことを伝える  
Subject: 利用申請の審査結果について／The results of the review of your application  
本文:  
\[restricted\_site\_name\_ja\]です。*

*下記の利用申請を却下しました。*

*申請番号： \[restricted\_activity\_id\]  
登録者名： \[restricted\_fullname\]  
メールアドレス： \[restricted\_mail\_address\]  
所属機関：\[restricted\_university\_institution\]  
研究題目：\[restricted\_research\_title\]  
申請データ：\[restricted\_data\_name\]  
申請年月日：\[restricted\_application\_date\]*

*このメールは自動送信されているので返信しないでください。  
お問い合わせは下記までお願いします。また、このメールに心当たりのない方は、\[restricted\_site\_name\_ja\] までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*This is a message from \[restricted\_site\_name\_en\].  
Your application below has been rejected.*

*Application No.：\[restricted\_activity\_id\]  
Name：\[restricted\_fullname\]  
E-mail：\[restricted\_mail\_address\]  
Affiliation：\[restricted\_university\_institution\]  
Title of research：\[restricted\_research\_title\]  
Dataset requested ：\[restricted\_data\_name\]  
Application date：\[restricted\_application\_date\]*

*Please do not reply to this email as it has been sent automatically.  
Please direct all inquiries to the following address.  
Also, if you received this message in error, please notify \[restricted\_site\_name\_en\].*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]  
E-mail：\[restricted\_site\_mail\]*

*⑥ DLリンクをクリックし、DLした申請者に対して利用報告のアドレスが送付される  
Subject: 利用報告の登録のお願い／Request for register Data Usage Report  
本文:  
\[restricted\_site\_name\_ja\]です。  
下記で申請いただいデータについてダウンロードされたことを確認しました。*

*申請番号： \[restricted\_usage\_activity\_id\]  
登録者名： \[restricted\_fullname\]  
メールアドレス： \[restricted\_mail\_address\]  
所属機関：\[restricted\_university\_institution\]  
研究題目：\[restricted\_research\_title\]  
申請データ：\[restricted\_data\_name\]  
申請年月日：\[restricted\_application\_date\]*

*ダウンロードしたデータについて、下記のリンクから利用報告の登録をお願いします。*

*\[usage\_report\_url\]*

*このメールは自動送信されているので返信しないでください。  
お問い合わせは下記までお願いします。また、このメールに心当たりのない方は、\[restricted\_site\_name\_ja\]までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*This is a message from \[restricted\_site\_name\_en\].  
We have confirmed that the dataset which you registered at below has been downloaded.*

*Application No.：\[restricted\_usage\_activity\_id\]  
Name：\[restricted\_fullname\]  
E-mail：\[restricted\_mail\_address\]  
Affiliation：\[restricted\_university\_institution\]  
Title of research：\[restricted\_research\_title\]  
Dataset requested ：\[restricted\_data\_name\]  
Application date：\[restricted\_application\_date\]*

*For the downloaded data, please register the Data Usage Report by the link below.*

*\[usage\_report\_url\]*

*Please do not reply to this email as it has been sent automatically.  
Please direct all inquiries to the following address.  
Also, if you received this message in error, please notify \[restricted\_site\_name\_en\].*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]*

*E-mail：\[restricted\_site\_mail\]*

*⑦ 管理者画面より、申請者に対して利用報告のリマインドを行う  
Subject: 利用報告の登録のお願い／Request for register Data Usage Report  
本文:  
\[restricted\_site\_name\_ja\]です。  
現時点で、下記の利用報告が登録されていません*

*報告番号：\[restricted\_activity\_id\]  
登録者名：\[restricted\_fullname\]  
メールアドレス：\[restricted\_mail\_address\]  
所属機関：\[restricted\_university\_institution\]  
利用データ：\[restricted\_data\_name\]  
データダウンロード日：\[data\_download\_date\]*

*下記のリンクから利用報告の登録をお願いします。*

*\[usage\_report\_url\]*

*このメールは自動送信されているので返信しないでください。  
お問い合わせは下記までお願いします。また、このメールに心当たりのない方は、\[restricted\_site\_name\_ja\]までご連絡ください。*

*\[restricted\_site\_name\_ja\]：\[restricted\_site\_url\]  
問い合わせ窓口：\[restricted\_site\_mail\]*

*This is a message from \[restricted\_site\_name\_en\].  
At this time, the Data Usage Report below has not been registered.*

*Usage Report No.：\[restricted\_activity\_id\]  
Name：\[restricted\_fullname\]  
E-mail：\[restricted\_mail\_address\]  
Affiliation：\[restricted\_university\_institution\]  
Usage Dataset：\[restricted\_data\_name\]  
Download date：\[data\_download\_date\]*

*Please register the Data Usage Report from the link below.*

*\[usage\_report\_url\]*

*Please do not reply to this email as it has been sent automatically.  
Please direct all inquiries to the following address.  
Also, if you received this message in error, please notify \[restricted\_site\_name\_en\].*

*\[restricted\_site\_name\_en\]：\[restricted\_site\_url\]  
E-mail：\[restricted\_site\_mail\]*

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
<p>2023/08/31</p>
</blockquote></td>
<td>353ba1deb094af5056a58bb40f07596b8e95a562</td>
<td>初版作成</td>
</tr>
<tr class="even">
<td><blockquote>
<p>2024/10/31</p>
</blockquote></td>
<td>edd6d1f14e0f8344cec7552ed8a02bd2bccf68b7</td>
<td>メールテンプレート拡張機能を追加</td>
</tr>
</tbody>
</table>