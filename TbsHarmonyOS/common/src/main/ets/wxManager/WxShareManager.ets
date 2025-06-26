class WxShareManager{
  private constructor() {
  }
  private static INSTANCE:WxShareManager

  public static getInstance():WxShareManager{
    if(!WxShareManager.INSTANCE){
      WxShareManager.INSTANCE = new WxShareManager()
    }
    return WxShareManager.INSTANCE
  }
}
export const wxShareManager = WxShareManager.getInstance()