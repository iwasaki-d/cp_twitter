class SearchesController < ApplicationController

  def search

    # Tweets.ransackではtweetsテーブルに対してuserテーブルがleft_outer_joinでつながるので、tweet.bodyとuser.nameで検索をかけた場合に
    # Tweetsがないユーザーは取得できない
    @tweets = Tweet.ransack(ransack_params).result

    # Tweetsとは逆にuserテーブルに対してtweetsテーブルをleft_outer_joinさせる検索も実行して、tweetsがないユーザーも検索結果に表示させる
    @users  = User.ransack({name_or_tweets_body_cont: ransack_params[:body_or_user_name_cont]}).result
  end

  private

  def ransack_params
    params.require(:q).permit(:body_or_user_name_cont)
  end
end
