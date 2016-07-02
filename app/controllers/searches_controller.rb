class SearchesController < ApplicationController

  def search
    # Tweets.ransackではtweetsテーブルに対してuserテーブルがleft_outer_joinでつながるので、tweet.bodyとuser.nameで検索をかけた場合に
    # Tweetsがないユーザーは取得できないことに注意
    # user.nameとtweet.bodyに対して Like %xxx%の検索をかけるのでレコード量に注意
    @tweets = Tweet.ransack(ransack_params).result(distinct: true).page(params[:tweets_page]).per(Constants::SEARCH_TWEETS_PAR)

    # 検索フォームから検索条件の入力を1回でtweetsとuserを検索したいため、tweetの検索条件からuserの検索条件を作成している
    @users = User.ransack({name_or_tweets_body_cont: ransack_params[:body_or_user_name_cont]}).result(distinct: true)
               .page(params[:users_page]).per(Constants::SEARCH_USERS_PAR)
  end

  private

  def ransack_params
    params.require(:q).permit(:body_or_user_name_cont)
  end
end
