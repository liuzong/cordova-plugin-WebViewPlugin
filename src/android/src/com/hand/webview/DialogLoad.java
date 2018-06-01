package com.hand.webview;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.AnimationDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;

/**
 * Created by panx on 2017/3/30.
 */
public class DialogLoad extends Dialog {
    private ImageView imgLoad;
    public DialogLoad(Context context) {
        super(context,Util.getRS("Dialog_No_Border","style",context));
        LayoutInflater layoutInflater = LayoutInflater.from(context);
        View view = layoutInflater.inflate(Util.getRS("dialog_loading","layout",context),null);
        this.setContentView(view);
        imgLoad = (ImageView) view.findViewById(Util.getRS("img_load","id",context));
        WindowManager.LayoutParams lp = this.getWindow().getAttributes();
        // 设置背景层透明度
        lp.dimAmount = 0.0f;
        this.getWindow().setAttributes(lp);
        this.setCancelable(false);
    }

    @Override
    public void show() {
        if(this.isShowing()){
            return;
        }
        super.show();
        imgLoad.setImageResource(Util.getRS("anim_loading","drawable",getContext()));
        AnimationDrawable animationDrawable = (AnimationDrawable) imgLoad.getDrawable();
        animationDrawable.start();
    }

    @Override
    public void dismiss() {
        try {
            AnimationDrawable animationDrawable = (AnimationDrawable) imgLoad.getDrawable();
            animationDrawable.stop();
            imgLoad.setImageResource(Util.getRS("load1","drawable",getContext()));
        }catch (Exception e){

        }
        if(getWindow()!=null){
            super.dismiss();
        }
    }
}
