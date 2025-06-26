import { pasteboard } from '@kit.BasicServicesKit';

//复制文本组件
export const copyText = (textContent: string): void => {
  let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textContent);
  let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
  try {
    systemPasteboard.setDataSync(pasteData);
  } catch (err) {
    console.log('lucy==' + err.message)
  }
  ;
}
