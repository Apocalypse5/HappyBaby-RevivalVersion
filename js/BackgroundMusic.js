// 注册背景音乐资源
createjs.Sound.registerSound("./bgm/Home.mp3", "backgroundMusicHome");
createjs.Sound.registerSound("./bgm/Christmas.mp3", "backgroundMusicChristmas");
createjs.Sound.registerSound("./bgm/Cafe.mp3", "backgroundMusicCafe");
createjs.Sound.registerSound("./bgm/Outside.mp3", "backgroundMusicOutside");
createjs.Sound.registerSound("./bgm/Store.mp3", "backgroundMusicStore");

createjs.Sound.registerSound("./bgm/CDs/Michael Jackson - Beat It.mp3", "backgroundMusicCD1");
createjs.Sound.registerSound("./bgm/CDs/久石譲 - 天空之城.mp3", "backgroundMusicCD2");
createjs.Sound.registerSound("./bgm/CDs/群星 - 虫儿飞.mp3", "backgroundMusicCD3");

// 设置背景音乐播放的参数
function playBackgroundMusic() {
    // 播放背景音乐，设置循环次数为-1（单曲循环），调整音量
    createjs.Sound.play("backgroundMusicHome", { loop: -1, volume: 0.5 });
	
	setTimeout(() => {
	        // 停止当前音乐播放
	        createjs.Sound.stop();
	
	        // 播放 Store.mp3 背景音乐，设置循环次数为-1（单曲循环），调整音量
	        createjs.Sound.play("backgroundMusicCD3", { loop: -1, volume: 0.5 });
	    }, 5000);
}

// 在用户点击舞台时播放背景音乐
document.addEventListener("click", () => {
    playBackgroundMusic(); // 用户点击后播放背景音乐
}, { once: true });  // 确保只触发一次