// リファレンスに沿ってcable.jsのファイル名称を利用するとうまくいかない。
// rails4ではaciton_cable自身もcable.js.erbというファイルを利用しており、asset_pipelineで
// うまく読み込まれなかった。
(function() {
    this.App || (this.App = {});

    App.cable = Cable.createConsumer("/cable");
}).call(this);
