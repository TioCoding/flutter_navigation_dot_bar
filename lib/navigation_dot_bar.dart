library navigation_dot_bar;

import 'package:flutter/material.dart';

class BottomNavigationDotBar extends StatefulWidget{

  final List<BottomNavigationDotBarItem> items;
  final Color? activeColor;
  final Color? color;
  final int initialPosition;
  final double? elevation;
  final BorderRadiusGeometry? border;
  final EdgeInsetsGeometry? padding;
  final int? animationSpeed;
  final CircleAvatar? indicator;
  final bool useThemeColors;

  const BottomNavigationDotBar({
    required this.items, 
    this.activeColor, 
    this.color, 
    this.initialPosition = 0, 
    this.elevation,
    this.border,
    this.padding,
    this.animationSpeed,
    this.indicator,
    this.useThemeColors = false,
    Key? key
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationDotBarState();

}

class _BottomNavigationDotBarState extends State<BottomNavigationDotBar>{

  GlobalKey _keyBottomBar = GlobalKey();
  double _numPositionBase = 0.0;
  double _numDifferenceBase = 0.0;
  double? _positionLeftIndicatorDot;
  int _indexPageSelected = 1;
  Color? _color;
  Color? _activeColor;
  
  double? _elevation;
  BorderRadiusGeometry? _border;
  EdgeInsetsGeometry? _padding;
  int? _animationSpeed;
  CircleAvatar? _indicator;

  @override
  void initState() {
    _elevation = widget.elevation ?? 5;
    _border = widget.border ?? BorderRadius.circular(10);
    _padding = widget.padding ?? EdgeInsets.fromLTRB(10, 0, 10, 5);
    _animationSpeed = widget.animationSpeed ?? 400;
    _indicator = widget.indicator ?? CircleAvatar(radius: 2.5, backgroundColor: widget.useThemeColors ? _activeColor : Colors.black);
    WidgetsBinding.instance!.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _afterLayout(_) {
    _indexPageSelected = widget.initialPosition;
    _color = widget.color ?? Colors.black45;
    
    final sizeBottomBar = (_keyBottomBar.currentContext!.findRenderObject() as RenderBox).size;
    _numPositionBase = ((sizeBottomBar.width / widget.items.length));
    _numDifferenceBase = (_numPositionBase - (_numPositionBase / 2) + 2);
    setState(() { 
      _activeColor = widget.activeColor ?? Theme.of(context).primaryColor;
      _positionLeftIndicatorDot = (_numPositionBase * (_indexPageSelected+1))-_numDifferenceBase; 
    });
  }

  @override
  Widget build(BuildContext context) => Container (
    padding: _padding,
    child: Material(
        elevation: _elevation!,
        borderRadius: _border,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Stack(
            key: _keyBottomBar,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _createNavigationIconButtonList(widget.items.asMap())
                ),
              ),
              AnimatedPositioned(
                  child: _indicator!,
                  duration: Duration(milliseconds: _animationSpeed!),
                  curve: Curves.fastOutSlowIn,
                  left: _positionLeftIndicatorDot,
                  bottom: 0
              ),
            ],
          ),
        )
    ),
  );

  List<_NavigationIconButton> _createNavigationIconButtonList(Map<int, BottomNavigationDotBarItem> mapItem){
    List<_NavigationIconButton> children = [];
    mapItem.forEach((index, item) =>
        children.add(_NavigationIconButton(item.icon, (index == _indexPageSelected) ? _activeColor : _color,item.onTap,() { _changeOptionBottomBar(index); }))
    );
    return children;
  }

  void _changeOptionBottomBar(int indexPageSelected){
    if(indexPageSelected != _indexPageSelected){
      setState(() { 
        _positionLeftIndicatorDot = (_numPositionBase * (indexPageSelected+1))-_numDifferenceBase; 
      });
      _indexPageSelected = indexPageSelected;
    }
  }

}

class BottomNavigationDotBarItem{
  final IconData icon;
  final NavigationIconButtonTapCallback onTap;
  const BottomNavigationDotBarItem({required this.icon, required this.onTap}) : assert(icon != null);
}

typedef NavigationIconButtonTapCallback = void Function();

class _NavigationIconButton extends StatefulWidget {

  final IconData _icon;
  final Color? _colorIcon;
  final NavigationIconButtonTapCallback _onTapInternalButton;
  final NavigationIconButtonTapCallback _onTapExternalButton;

  const _NavigationIconButton(this._icon, this._colorIcon, this._onTapInternalButton, this._onTapExternalButton, {Key? key}): super(key: key);

  @override
  _NavigationIconButtonState createState() => _NavigationIconButtonState();

}

class _NavigationIconButtonState extends State<_NavigationIconButton> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  double _opacityIcon = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.93).animate(_controller!.view);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTapDown: (_) {
        _controller!.forward();
        setState(() { _opacityIcon = 0.7; });
      },
      onTapUp: (_) {
        _controller!.reverse();
        setState(() { _opacityIcon = 1; });
      },
      onTapCancel: () {
        _controller!.reverse();
        setState(() { _opacityIcon = 1; });
      },
      onTap: () {
        widget._onTapInternalButton();
        widget._onTapExternalButton();
      },
      child: ScaleTransition(
          scale: _scaleAnimation!,
          child: AnimatedOpacity(
              opacity: _opacityIcon,
              duration: Duration(milliseconds: 200),
              child: Icon(widget._icon, color: widget._colorIcon)
          )
      )
  );
}
