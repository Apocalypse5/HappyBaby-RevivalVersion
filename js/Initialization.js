var canvas = document.getElementById('canvasElementId');  // 获取canvas元素

function checkStageInitialization() { // 使用requestAnimationFrame来确保在绘制循环开始时执行代码
    if (stage) {
        var boyaa = new PreLoad.HbObject_Boyaa();
        boyaa.setTransform(310,300);
        stage.addChild(boyaa);
        
        (async () => {
						await new Promise(resolve => setTimeout(resolve, 2000)); // 等待 2 秒
						stage.removeChild(boyaa);
						var logo = new PreLoad.HbObject_Logo();
						logo.setTransform(380,300);
						stage.addChild(logo);
						
						import('./CustomCursor.js');
						
						// 添加帧事件监听，让其停止在第25帧
						logo.on("tick", () => {
						  if (logo.currentFrame >= 25) {
						    logo.stop(); // 在第 25 帧停止
						    logo.removeAllEventListeners("tick");
						    
						    const queue = new createjs.LoadQueue();

								const resources = [
									{ src: "./bgm/Home.mp3", id: "sb" },

								];

								const totalFiles = resources.length; // 总文件数量
								let loadedFiles = 0; // 已加载文件数
								
								// 监听每个文件加载完成的事件
								function onFileLoad(event) {
								  loadedFiles++; // 已加载文件数 +1
								  const progress = Math.floor((loadedFiles / totalFiles) * 100); // 计算百分比
								  logo.progressText.text = `${progress}%`; // 更新文本
								  //console.log(`文件加载完成: ${event.item.id}`);
								}
								// 监听所有文件加载完成
								function onComplete() {
								  logo.progressText.text = "100%"; // 更新文本为100%
								  logo.play();
								  logo.on("tick", () => {
									  // 判断当前帧是否到达动画的结尾
									  if (logo.currentFrame === logo.totalFrames - 1) {
									    console.log("logo 动画播放完成，移除监听器和对象");
									    // 移除所有事件监听器
									    logo.removeAllEventListeners();
									    // 从舞台移除logo对象
									    stage.removeChild(logo);
									    import('./EnterScene.js');
									  }
									});
								  // 移除事件监听器，防止重复触发
								  queue.removeEventListener("fileload", onFileLoad);
								  queue.removeEventListener("complete", onComplete);
								}
								
								// 添加事件监听
								queue.on("fileload", onFileLoad);
								queue.on("complete", onComplete);
								// 开始加载资源
								queue.loadManifest(resources);
						  }
						});
				})();
    } else {
        requestAnimationFrame(checkStageInitialization); // 如果stage还没准备好，继续等待
    }
}
checkStageInitialization();