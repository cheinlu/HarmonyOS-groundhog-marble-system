<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
		onShareAppMessage() {
			return {
				title:'分享',
				path:"/pages/home/home"
			}
		}
	}
</script>

<style lang="scss">
	/* 需要给style标签加入lang="scss"属性 */
	@import "@/uni_modules/uview-plus/index.scss";
</style>
