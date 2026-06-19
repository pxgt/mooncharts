(() => {
  function _M0TPB13StringBuilder(param0) {
    this.val = param0;
  }
  const _M0FPB19int__to__string__js = (x, radix) => {
    return x.toString(radix);
  };
  function $bound_check(arr, index) {
    if (index < 0 || index >= arr.length) throw new Error("Index out of bounds");
  }
  const _M0MPB7JSArray4push = (arr, val) => { arr.push(val); };
  class $PanicError extends Error {}
  function $panic() {
    throw new $PanicError();
  }
  function _M0TP25Xpeng10mooncharts5Theme(param0, param1, param2, param3, param4, param5) {
    this.palette = param0;
    this.background = param1;
    this.grid = param2;
    this.axis = param3;
    this.text = param4;
    this.title = param5;
  }
  const _M0FP25Xpeng10mooncharts14light__palette = ["#4e79a7", "#f28e2b", "#e15759", "#76b7b2", "#59a14f", "#edc948", "#b07aa1", "#ff9da7", "#9c755f", "#bab0ac"];
  const _M0FP25Xpeng10mooncharts13dark__palette = ["#6ea8e0", "#f6a04d", "#ef6f70", "#8fd4cd", "#7fc06a", "#f2d65c", "#c79bc0", "#ffb3bb", "#bd9279", "#cfcac4"];
  const _M0FP25Xpeng10mooncharts8documentN5tupleS948 = { _0: "xmlns", _1: "http://www.w3.org/2000/svg" };
  const _M0FP25Xpeng10mooncharts13label_2einnerN5tupleS947 = { _0: "font-family", _1: "sans-serif" };
  const _M0FP25Xpeng10mooncharts7y__axisN5tupleS950 = { _0: "stroke-width", _1: "1" };
  const _M0FP25Xpeng10mooncharts18legend__horizontalN5tupleS952 = { _0: "rx", _1: "2" };
  const _M0FP25Xpeng10mooncharts16background__rectN5tupleS945 = { _0: "x", _1: "0" };
  const _M0FP25Xpeng10mooncharts16background__rectN5tupleS946 = { _0: "y", _1: "0" };
  const _M0FP25Xpeng10mooncharts6extentN5tupleS949 = { _0: 0, _1: 1 };
  const _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS973 = { _0: "fill-opacity", _1: "0.18" };
  const _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS974 = { _0: "fill", _1: "none" };
  const _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS975 = { _0: "stroke-width", _1: "2" };
  const _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS976 = { _0: "stroke-linejoin", _1: "round" };
  const _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS977 = { _0: "stroke-linecap", _1: "round" };
  const _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS978 = { _0: "r", _1: "3" };
  const _M0FP25Xpeng10mooncharts22scatter__chart_2einnerN5tupleS951 = { _0: "fill-opacity", _1: "0.7" };
  const _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS966 = { _0: "fill", _1: "none" };
  const _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS967 = { _0: "stroke-width", _1: "2" };
  const _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS968 = { _0: "stroke-linejoin", _1: "round" };
  const _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS969 = { _0: "stroke-linecap", _1: "round" };
  const _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS970 = { _0: "r", _1: "3" };
  const _M0FP25Xpeng10mooncharts27bar__chart__grouped_2einnerN5tupleS972 = { _0: "rx", _1: "1" };
  const _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS953 = { _0: "fill", _1: "none" };
  const _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS954 = { _0: "stroke-width", _1: "1" };
  const _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS955 = { _0: "stroke-width", _1: "1" };
  const _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS956 = { _0: "fill-opacity", _1: "0.15" };
  const _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS957 = { _0: "stroke-width", _1: "2" };
  const _M0FP25Xpeng10mooncharts18pie__chart_2einnerN5tupleS958 = { _0: "width", _1: "12" };
  const _M0FP25Xpeng10mooncharts18pie__chart_2einnerN5tupleS959 = { _0: "height", _1: "12" };
  const _M0FP25Xpeng10mooncharts18pie__chart_2einnerN5tupleS960 = { _0: "rx", _1: "2" };
  const _M0FP25Xpeng10mooncharts18bar__chart_2einnerN5tupleS971 = { _0: "rx", _1: "2" };
  const _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS961 = { _0: "fill", _1: "none" };
  const _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS962 = { _0: "stroke-width", _1: "2" };
  const _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS963 = { _0: "stroke-linejoin", _1: "round" };
  const _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS964 = { _0: "stroke-linecap", _1: "round" };
  const _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS965 = { _0: "r", _1: "3" };
  function _M0MPB13StringBuilder21StringBuilder_2einner(size_hint) {
    return new _M0TPB13StringBuilder("");
  }
  function _M0IPB13StringBuilderPB6Logger11write__char(self, ch) {
    self.val = `${self.val}${String.fromCodePoint(ch)}`;
  }
  function _M0IPB13StringBuilderPB6Logger13write__string(self, str) {
    self.val = `${self.val}${str}`;
  }
  function _M0MPC13int3Int18to__string_2einner(self, radix) {
    return _M0FPB19int__to__string__js(self, radix);
  }
  function _M0MPC15array5Array4pushGUsdEE(self, value) {
    _M0MPB7JSArray4push(self, value);
  }
  function _M0MPC15array5Array4pushGdE(self, value) {
    _M0MPB7JSArray4push(self, value);
  }
  function _M0MPC16double6Double7to__int(self) {
    return self !== self ? 0 : self >= 2147483647 ? 2147483647 : self <= -2147483648 ? -2147483648 : self | 0;
  }
  function _M0MPC16double6Double4ceil(_tmp) {
    return Math.ceil(_tmp);
  }
  function _M0MPC16double6Double5floor(_tmp) {
    return Math.floor(_tmp);
  }
  function _M0MPC16double6Double5round(_tmp) {
    return Math.round(_tmp);
  }
  function _M0MPC15array5Array2atGdE(self, index) {
    const len = self.length;
    if (index >= 0 && index < len) {
      $bound_check(self, index);
      return self[index];
    } else {
      return $panic();
    }
  }
  function _M0MPC15array5Array2atGsE(self, index) {
    const len = self.length;
    if (index >= 0 && index < len) {
      $bound_check(self, index);
      return self[index];
    } else {
      return $panic();
    }
  }
  function _M0FPC16double4ceil(d) {
    return _M0MPC16double6Double4ceil(d);
  }
  function _M0FPC16double5floor(d) {
    return _M0MPC16double6Double5floor(d);
  }
  function _M0FPC14math3sin(_tmp) {
    return Math.sin(_tmp);
  }
  function _M0FPC14math3cos(_tmp) {
    return Math.cos(_tmp);
  }
  function _M0FPC14math3pow(_tmp, _tmp$2) {
    return Math.pow(_tmp, _tmp$2);
  }
  function _M0FPC14math5log10(_tmp) {
    return Math.log10(_tmp);
  }
  function _M0FP25Xpeng10mooncharts9nice__num(x, round) {
    const exp = _M0FPC16double5floor(_M0FPC14math5log10(x));
    const frac = x / _M0FPC14math3pow(10, exp);
    const nice = round ? (frac < 1.5 ? 1 : frac < 3 ? 2 : frac < 7 ? 5 : 10) : frac <= 1 ? 1 : frac <= 2 ? 2 : frac <= 5 ? 5 : 10;
    return nice * _M0FPC14math3pow(10, exp);
  }
  function _M0FP25Xpeng10mooncharts11nice__ticks(lo, hi, target) {
    const hi$2 = hi <= lo ? lo + 1 : hi;
    const count = target < 2 ? 2 : target;
    const span = _M0FP25Xpeng10mooncharts9nice__num(hi$2 - lo, false);
    const step = _M0FP25Xpeng10mooncharts9nice__num(span / ((count - 1 | 0) + 0), true);
    const axis_lo = _M0FPC16double5floor(lo / step) * step;
    const axis_hi = _M0FPC16double4ceil(hi$2 / step) * step;
    const n = _M0MPC16double6Double7to__int((axis_hi - axis_lo) / step) + 1 | 0;
    const ticks = [];
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < n) {
        _M0MPC15array5Array4pushGdE(ticks, axis_lo + (i + 0) * step);
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return { _0: axis_lo, _1: axis_hi, _2: ticks };
  }
  function _M0MP25Xpeng10mooncharts5Theme5light() {
    return new _M0TP25Xpeng10mooncharts5Theme(_M0FP25Xpeng10mooncharts14light__palette, "", "#e6e6e6", "#999999", "#333333", "#222222");
  }
  function _M0MP25Xpeng10mooncharts5Theme4dark() {
    return new _M0TP25Xpeng10mooncharts5Theme(_M0FP25Xpeng10mooncharts13dark__palette, "#1e1e2e", "#39394d", "#8888a0", "#cdd0e0", "#f0f0f8");
  }
  function _M0MP25Xpeng10mooncharts5Theme9color__at(self, i) {
    return _M0MPC15array5Array2atGsE(self.palette, i % self.palette.length | 0);
  }
  function _M0FP25Xpeng10mooncharts6escape(s) {
    const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    const _bind = s.length;
    let _tmp = 0;
    while (true) {
      const _string_index = _tmp;
      if (_string_index < _bind) {
        let _decoded_next_string_index;
        let _decoded_char;
        _L: {
          const _bind$2 = s.charCodeAt(_string_index);
          if (_bind$2 >= 55296 && _bind$2 <= 56319 && (_string_index + 1 | 0) < _bind) {
            const _bind$3 = s.charCodeAt(_string_index + 1 | 0);
            if (_bind$3 >= 56320 && _bind$3 <= 57343) {
              const _tmp$2 = _string_index + 2 | 0;
              const _p = (((Math.imul(_bind$2 - 55296 | 0, 1024) | 0) + _bind$3 | 0) - 56320 | 0) + 65536 | 0;
              _decoded_next_string_index = _tmp$2;
              _decoded_char = _p;
              break _L;
            } else {
              const _tmp$2 = _string_index + 1 | 0;
              const _p = _bind$2;
              _decoded_next_string_index = _tmp$2;
              _decoded_char = _p;
              break _L;
            }
          } else {
            const _tmp$2 = _string_index + 1 | 0;
            const _p = _bind$2;
            _decoded_next_string_index = _tmp$2;
            _decoded_char = _p;
            break _L;
          }
        }
        switch (_decoded_char) {
          case 38: {
            _M0IPB13StringBuilderPB6Logger13write__string(sb, "&amp;");
            break;
          }
          case 60: {
            _M0IPB13StringBuilderPB6Logger13write__string(sb, "&lt;");
            break;
          }
          case 62: {
            _M0IPB13StringBuilderPB6Logger13write__string(sb, "&gt;");
            break;
          }
          case 34: {
            _M0IPB13StringBuilderPB6Logger13write__string(sb, "&quot;");
            break;
          }
          case 39: {
            _M0IPB13StringBuilderPB6Logger13write__string(sb, "&#39;");
            break;
          }
          default: {
            _M0IPB13StringBuilderPB6Logger11write__char(sb, _decoded_char);
          }
        }
        _tmp = _decoded_next_string_index;
        continue;
      } else {
        break;
      }
    }
    return sb.val;
  }
  function _M0FP25Xpeng10mooncharts13render__attrs(attrs) {
    const sb = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    const _bind = attrs.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const pair = attrs[_];
        const _k = pair._0;
        const _v = pair._1;
        _M0IPB13StringBuilderPB6Logger13write__string(sb, " ");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _k);
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "=\"");
        _M0IPB13StringBuilderPB6Logger13write__string(sb, _M0FP25Xpeng10mooncharts6escape(_v));
        _M0IPB13StringBuilderPB6Logger13write__string(sb, "\"");
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return sb.val;
  }
  function _M0FP25Xpeng10mooncharts4elem(tag, attrs) {
    return `<${tag}${_M0FP25Xpeng10mooncharts13render__attrs(attrs)} />`;
  }
  function _M0FP25Xpeng10mooncharts3num(x) {
    const neg = x < 0;
    const abs = neg ? -x : x;
    const hundredths = _M0MPC16double6Double7to__int(_M0MPC16double6Double5round(abs * 100));
    const whole = hundredths / 100 | 0;
    const frac = hundredths % 100 | 0;
    const sign = neg && hundredths !== 0 ? "-" : "";
    return frac === 0 ? `${sign}${_M0MPC13int3Int18to__string_2einner(whole, 10)}` : (frac % 10 | 0) === 0 ? `${sign}${_M0MPC13int3Int18to__string_2einner(whole, 10)}.${_M0MPC13int3Int18to__string_2einner(frac / 10 | 0, 10)}` : frac < 10 ? `${sign}${_M0MPC13int3Int18to__string_2einner(whole, 10)}.0${_M0MPC13int3Int18to__string_2einner(frac, 10)}` : `${sign}${_M0MPC13int3Int18to__string_2einner(whole, 10)}.${_M0MPC13int3Int18to__string_2einner(frac, 10)}`;
  }
  function _M0FP25Xpeng10mooncharts16background__rect(theme, width, height) {
    return theme.background === "" ? "" : _M0FP25Xpeng10mooncharts4elem("rect", [_M0FP25Xpeng10mooncharts16background__rectN5tupleS945, _M0FP25Xpeng10mooncharts16background__rectN5tupleS946, { _0: "width", _1: _M0FP25Xpeng10mooncharts3num(width) }, { _0: "height", _1: _M0FP25Xpeng10mooncharts3num(height) }, { _0: "fill", _1: theme.background }]);
  }
  function _M0FP25Xpeng10mooncharts4text(x, y, content, attrs) {
    const base = [{ _0: "x", _1: _M0FP25Xpeng10mooncharts3num(x) }, { _0: "y", _1: _M0FP25Xpeng10mooncharts3num(y) }];
    const _bind = attrs.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const pair = attrs[_];
        _M0MPC15array5Array4pushGUsdEE(base, pair);
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return `<text${_M0FP25Xpeng10mooncharts13render__attrs(base)}>${_M0FP25Xpeng10mooncharts6escape(content)}</text>`;
  }
  function _M0FP25Xpeng10mooncharts13label_2einner(x, y, content, size, anchor, weight, fill) {
    return _M0FP25Xpeng10mooncharts4text(x, y, content, [{ _0: "text-anchor", _1: anchor }, _M0FP25Xpeng10mooncharts13label_2einnerN5tupleS947, { _0: "font-size", _1: _M0MPC13int3Int18to__string_2einner(size, 10) }, { _0: "font-weight", _1: weight }, { _0: "fill", _1: fill }]);
  }
  function _M0FP25Xpeng10mooncharts9container(tag, attrs, inner) {
    return `<${tag}${_M0FP25Xpeng10mooncharts13render__attrs(attrs)}>${inner}</${tag}>`;
  }
  function _M0FP25Xpeng10mooncharts8document(width, height, body) {
    const attrs = [_M0FP25Xpeng10mooncharts8documentN5tupleS948, { _0: "width", _1: _M0FP25Xpeng10mooncharts3num(width) }, { _0: "height", _1: _M0FP25Xpeng10mooncharts3num(height) }, { _0: "viewBox", _1: `0 0 ${_M0FP25Xpeng10mooncharts3num(width)} ${_M0FP25Xpeng10mooncharts3num(height)}` }];
    return _M0FP25Xpeng10mooncharts9container("svg", attrs, body);
  }
  function _M0FP25Xpeng10mooncharts6extent(values) {
    if (values.length === 0) {
      return _M0FP25Xpeng10mooncharts6extentN5tupleS949;
    }
    let lo = _M0MPC15array5Array2atGdE(values, 0);
    let hi = _M0MPC15array5Array2atGdE(values, 0);
    const _bind = values.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const v = values[_];
        if (v < lo) {
          lo = v;
        }
        if (v > hi) {
          hi = v;
        }
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return { _0: lo, _1: hi };
  }
  function _M0FP25Xpeng10mooncharts13scale__linear(v, d0, d1, r0, r1) {
    return d0 === d1 ? (r0 + r1) / 2 : r0 + (v - d0) / (d1 - d0) * (r1 - r0);
  }
  function _M0FP25Xpeng10mooncharts7y__axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks) {
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    const _bind = ticks.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const t = ticks[_];
        const y = _M0FP25Xpeng10mooncharts13scale__linear(t, axis_lo, axis_hi, top + plot_h, top);
        const stroke = t === axis_lo ? theme.axis : theme.grid;
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("line", [{ _0: "x1", _1: _M0FP25Xpeng10mooncharts3num(left) }, { _0: "y1", _1: _M0FP25Xpeng10mooncharts3num(y) }, { _0: "x2", _1: _M0FP25Xpeng10mooncharts3num(left + plot_w) }, { _0: "y2", _1: _M0FP25Xpeng10mooncharts3num(y) }, { _0: "stroke", _1: stroke }, _M0FP25Xpeng10mooncharts7y__axisN5tupleS950]));
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(left - 6, y + 4, _M0FP25Xpeng10mooncharts3num(t), 11, "end", "normal", theme.axis));
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return body.val;
  }
  function _M0FP25Xpeng10mooncharts22scatter__chart_2einner(data, title, width, height, radius, theme) {
    const top = title === "" ? 16 : 40;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 40;
    const _p = new Array(data.length);
    const _p$2 = data.length;
    let _tmp = 0;
    while (true) {
      const _p$3 = _tmp;
      if (_p$3 < _p$2) {
        const _p$4 = data[_p$3];
        _p[_p$3] = _p$4._0;
        _tmp = _p$3 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const xs = _p;
    const _p$3 = new Array(data.length);
    const _p$4 = data.length;
    let _tmp$2 = 0;
    while (true) {
      const _p$5 = _tmp$2;
      if (_p$5 < _p$4) {
        const _p$6 = data[_p$5];
        _p$3[_p$5] = _p$6._1;
        _tmp$2 = _p$5 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const ys = _p$3;
    const _bind = _M0FP25Xpeng10mooncharts6extent(xs);
    const _xlo = _bind._0;
    const _xhi = _bind._1;
    const _bind$2 = _M0FP25Xpeng10mooncharts6extent(ys);
    const _ylo = _bind$2._0;
    const _yhi = _bind$2._1;
    const xpad = (_xhi - _xlo) * 0.05;
    const _bind$3 = _M0FP25Xpeng10mooncharts11nice__ticks(_ylo, _yhi, 5);
    const _axis_lo = _bind$3._0;
    const _axis_hi = _bind$3._1;
    const _ticks = _bind$3._2;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    const color = _M0MP25Xpeng10mooncharts5Theme9color__at(theme, 0);
    const _bind$4 = data.length;
    let _tmp$3 = 0;
    while (true) {
      const i = _tmp$3;
      if (i < _bind$4) {
        const _bind$5 = _M0MPC15array5Array2atGsE(data, i);
        const _x = _bind$5._0;
        const _y = _bind$5._1;
        const px = _M0FP25Xpeng10mooncharts13scale__linear(_x, _xlo - xpad, _xhi + xpad, 48, 48 + plot_w);
        const py = _M0FP25Xpeng10mooncharts13scale__linear(_y, _axis_lo, _axis_hi, top + plot_h, top);
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("circle", [{ _0: "cx", _1: _M0FP25Xpeng10mooncharts3num(px) }, { _0: "cy", _1: _M0FP25Xpeng10mooncharts3num(py) }, { _0: "r", _1: _M0FP25Xpeng10mooncharts3num(radius) }, { _0: "fill", _1: color }, _M0FP25Xpeng10mooncharts22scatter__chart_2einnerN5tupleS951]));
        _tmp$3 = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const _p$5 = "";
    if (!(title === _p$5)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 24, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts12radar__angle(i, n) {
    return -1.5707963267948966 + (i + 0) * 2 * 3.1415926535897931 / (n + 0);
  }
  function _M0FP25Xpeng10mooncharts18legend__horizontal(items, center_x, y, text_color) {
    let total = 0;
    const _bind = items.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const it = items[_];
        const _name = it._0;
        total = total + (17 + (_name.length + 0) * 6.5 + 18);
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    if (items.length > 0) {
      total = total - 18;
    }
    let x = center_x - total / 2;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    const _bind$2 = items.length;
    let _tmp$2 = 0;
    while (true) {
      const _ = _tmp$2;
      if (_ < _bind$2) {
        const it = items[_];
        const _name = it._0;
        const _color = it._1;
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("rect", [{ _0: "x", _1: _M0FP25Xpeng10mooncharts3num(x) }, { _0: "y", _1: _M0FP25Xpeng10mooncharts3num(y - 11 + 2) }, { _0: "width", _1: _M0FP25Xpeng10mooncharts3num(11) }, { _0: "height", _1: _M0FP25Xpeng10mooncharts3num(11) }, { _0: "fill", _1: _color }, _M0FP25Xpeng10mooncharts18legend__horizontalN5tupleS952]));
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(x + 11 + 6, y, _name, 11, "start", "normal", text_color));
        x = x + (17 + (_name.length + 0) * 6.5 + 18);
        _tmp$2 = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    return body.val;
  }
  function _M0FP25Xpeng10mooncharts20radar__chart_2einner(axes, series, title, width, height, theme) {
    const title_h = title === "" ? 8 : 30;
    const top = title_h + 22;
    const n = axes.length;
    const cx = width / 2;
    const cy = top + (height - top) / 2;
    const by_h = (height - top - 36) / 2;
    const by_w = width / 2 - 64;
    const radius = by_h < by_w ? by_h : by_w;
    let max = 0;
    const _bind = series.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const s = series[_];
        const _bind$2 = s._1;
        const _bind$3 = _bind$2.length;
        let _tmp$2 = 0;
        while (true) {
          const _$2 = _tmp$2;
          if (_$2 < _bind$3) {
            const v = _bind$2[_$2];
            if (v > max) {
              max = v;
            }
            _tmp$2 = _$2 + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    if (max <= 0) {
      max = 1;
    }
    const _bind$2 = _M0FP25Xpeng10mooncharts11nice__ticks(0, max, 4);
    const _axis_hi = _bind$2._1;
    const _ticks = _bind$2._2;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    if (n >= 3) {
      const _bind$3 = _ticks.length;
      let _tmp$2 = 0;
      while (true) {
        const _ = _tmp$2;
        if (_ < _bind$3) {
          const t = _ticks[_];
          if (t > 0) {
            const rr = t / _axis_hi * radius;
            const ring = _M0MPB13StringBuilder21StringBuilder_2einner(0);
            let _tmp$3 = 0;
            while (true) {
              const i = _tmp$3;
              if (i < n) {
                const a = _M0FP25Xpeng10mooncharts12radar__angle(i, n);
                if (i > 0) {
                  _M0IPB13StringBuilderPB6Logger13write__string(ring, " ");
                }
                _M0IPB13StringBuilderPB6Logger13write__string(ring, `${_M0FP25Xpeng10mooncharts3num(cx + rr * _M0FPC14math3cos(a))},${_M0FP25Xpeng10mooncharts3num(cy + rr * _M0FPC14math3sin(a))}`);
                _tmp$3 = i + 1 | 0;
                continue;
              } else {
                break;
              }
            }
            _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("polygon", [{ _0: "points", _1: ring.val }, _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS953, { _0: "stroke", _1: theme.grid }, _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS954]));
          }
          _tmp$2 = _ + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      let _tmp$3 = 0;
      while (true) {
        const i = _tmp$3;
        if (i < n) {
          const a = _M0FP25Xpeng10mooncharts12radar__angle(i, n);
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("line", [{ _0: "x1", _1: _M0FP25Xpeng10mooncharts3num(cx) }, { _0: "y1", _1: _M0FP25Xpeng10mooncharts3num(cy) }, { _0: "x2", _1: _M0FP25Xpeng10mooncharts3num(cx + radius * _M0FPC14math3cos(a)) }, { _0: "y2", _1: _M0FP25Xpeng10mooncharts3num(cy + radius * _M0FPC14math3sin(a)) }, { _0: "stroke", _1: theme.grid }, _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS955]));
          const lx = cx + (radius + 16) * _M0FPC14math3cos(a);
          const ly = cy + (radius + 16) * _M0FPC14math3sin(a) + 4;
          const anchor = _M0FPC14math3cos(a) > 0.3 ? "start" : _M0FPC14math3cos(a) < -0.3 ? "end" : "middle";
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(lx, ly, _M0MPC15array5Array2atGsE(axes, i), 11, anchor, "normal", theme.axis));
          _tmp$3 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const _bind$4 = series.length;
      let _tmp$4 = 0;
      while (true) {
        const si = _tmp$4;
        if (si < _bind$4) {
          const vals = _M0MPC15array5Array2atGsE(series, si)._1;
          const color = _M0MP25Xpeng10mooncharts5Theme9color__at(theme, si);
          const poly = _M0MPB13StringBuilder21StringBuilder_2einner(0);
          let _tmp$5 = 0;
          while (true) {
            const i = _tmp$5;
            if (i < n) {
              const v = i < vals.length ? _M0MPC15array5Array2atGdE(vals, i) : 0;
              const rr = v / _axis_hi * radius;
              const a = _M0FP25Xpeng10mooncharts12radar__angle(i, n);
              if (i > 0) {
                _M0IPB13StringBuilderPB6Logger13write__string(poly, " ");
              }
              _M0IPB13StringBuilderPB6Logger13write__string(poly, `${_M0FP25Xpeng10mooncharts3num(cx + rr * _M0FPC14math3cos(a))},${_M0FP25Xpeng10mooncharts3num(cy + rr * _M0FPC14math3sin(a))}`);
              _tmp$5 = i + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("polygon", [{ _0: "points", _1: poly.val }, { _0: "fill", _1: color }, _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS956, { _0: "stroke", _1: color }, _M0FP25Xpeng10mooncharts20radar__chart_2einnerN5tupleS957]));
          _tmp$4 = si + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    const legend_items = [];
    const _bind$3 = series.length;
    let _tmp$2 = 0;
    while (true) {
      const si = _tmp$2;
      if (si < _bind$3) {
        _M0MPC15array5Array4pushGUsdEE(legend_items, { _0: _M0MPC15array5Array2atGsE(series, si)._0, _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, si) });
        _tmp$2 = si + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts18legend__horizontal(legend_items, width / 2, title_h + 14, theme.text));
    const _p = "";
    if (!(title === _p)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 20, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts5polar(cx, cy, r, angle) {
    return { _0: cx + r * _M0FPC14math3cos(angle), _1: cy + r * _M0FPC14math3sin(angle) };
  }
  function _M0FP25Xpeng10mooncharts9arc__path(cx, cy, r, inner, a0, a1) {
    const _bind = _M0FP25Xpeng10mooncharts5polar(cx, cy, r, a0);
    const _x0 = _bind._0;
    const _y0 = _bind._1;
    const _bind$2 = _M0FP25Xpeng10mooncharts5polar(cx, cy, r, a1);
    const _x1 = _bind$2._0;
    const _y1 = _bind$2._1;
    const large = a1 - a0 > 3.1415926535897931 ? "1" : "0";
    if (inner <= 0) {
      return `M ${_M0FP25Xpeng10mooncharts3num(cx)} ${_M0FP25Xpeng10mooncharts3num(cy)} L ${_M0FP25Xpeng10mooncharts3num(_x0)} ${_M0FP25Xpeng10mooncharts3num(_y0)} A ${_M0FP25Xpeng10mooncharts3num(r)} ${_M0FP25Xpeng10mooncharts3num(r)} 0 ${large} 1 ${_M0FP25Xpeng10mooncharts3num(_x1)} ${_M0FP25Xpeng10mooncharts3num(_y1)} Z`;
    } else {
      const _bind$3 = _M0FP25Xpeng10mooncharts5polar(cx, cy, inner, a0);
      const _xi0 = _bind$3._0;
      const _yi0 = _bind$3._1;
      const _bind$4 = _M0FP25Xpeng10mooncharts5polar(cx, cy, inner, a1);
      const _xi1 = _bind$4._0;
      const _yi1 = _bind$4._1;
      return `M ${_M0FP25Xpeng10mooncharts3num(_x0)} ${_M0FP25Xpeng10mooncharts3num(_y0)} A ${_M0FP25Xpeng10mooncharts3num(r)} ${_M0FP25Xpeng10mooncharts3num(r)} 0 ${large} 1 ${_M0FP25Xpeng10mooncharts3num(_x1)} ${_M0FP25Xpeng10mooncharts3num(_y1)} L ${_M0FP25Xpeng10mooncharts3num(_xi1)} ${_M0FP25Xpeng10mooncharts3num(_yi1)} A ${_M0FP25Xpeng10mooncharts3num(inner)} ${_M0FP25Xpeng10mooncharts3num(inner)} 0 ${large} 0 ${_M0FP25Xpeng10mooncharts3num(_xi0)} ${_M0FP25Xpeng10mooncharts3num(_yi0)} Z`;
    }
  }
  function _M0FP25Xpeng10mooncharts11emit__slice(body, cx, cy, r, inner, a0, a1, fill) {
    if (a1 - a0 >= 6.2831843071795861) {
      const mid = a0 + 3.1415926535897931;
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("path", [{ _0: "d", _1: _M0FP25Xpeng10mooncharts9arc__path(cx, cy, r, inner, a0, mid) }, { _0: "fill", _1: fill }]));
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("path", [{ _0: "d", _1: _M0FP25Xpeng10mooncharts9arc__path(cx, cy, r, inner, mid, a1) }, { _0: "fill", _1: fill }]));
      return;
    } else {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("path", [{ _0: "d", _1: _M0FP25Xpeng10mooncharts9arc__path(cx, cy, r, inner, a0, a1) }, { _0: "fill", _1: fill }]));
      return;
    }
  }
  function _M0FP25Xpeng10mooncharts18pie__chart_2einner(data, title, width, height, donut, theme) {
    const top = title === "" ? 16 : 40;
    let total = 0;
    const _bind = data.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const d = data[_];
        if (d._1 > 0) {
          total = total + d._1;
        }
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    if (total <= 0) {
      total = 1;
    }
    const cy = top + (height - top) / 2;
    let r = (height - top - 24) / 2;
    const max_r_by_width = (width - 140) / 2;
    if (r > max_r_by_width) {
      r = max_r_by_width;
    }
    const cx = 16 + r;
    const inner = donut > 0 ? r * donut : 0;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    let angle = -1.5707963267948966;
    const n = data.length;
    let legend_y = cy - (n + 0) * 20 / 2 + 10;
    const legend_x = cx + r + 20;
    let _tmp$2 = 0;
    while (true) {
      const i = _tmp$2;
      if (i < n) {
        const _bind$2 = _M0MPC15array5Array2atGsE(data, i);
        const _name = _bind$2._0;
        const _value = _bind$2._1;
        if (_value > 0) {
          const a0 = angle;
          const a1 = angle + _value / total * 3.1415926535897931 * 2;
          _M0FP25Xpeng10mooncharts11emit__slice(body, cx, cy, r, inner, a0, a1, _M0MP25Xpeng10mooncharts5Theme9color__at(theme, i));
          angle = a1;
        }
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("rect", [{ _0: "x", _1: _M0FP25Xpeng10mooncharts3num(legend_x) }, { _0: "y", _1: _M0FP25Xpeng10mooncharts3num(legend_y - 9) }, _M0FP25Xpeng10mooncharts18pie__chart_2einnerN5tupleS958, _M0FP25Xpeng10mooncharts18pie__chart_2einnerN5tupleS959, { _0: "fill", _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, i) }, _M0FP25Xpeng10mooncharts18pie__chart_2einnerN5tupleS960]));
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(legend_x + 18, legend_y, `${_name} (${_M0FP25Xpeng10mooncharts3num(_value)})`, 11, "start", "normal", theme.text));
        legend_y = legend_y + 20;
        _tmp$2 = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const _p = "";
    if (!(title === _p)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 24, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts19line__chart_2einner(data, title, width, height, theme) {
    const top = title === "" ? 16 : 40;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 40;
    const _p = new Array(data.length);
    const _p$2 = data.length;
    let _tmp = 0;
    while (true) {
      const _p$3 = _tmp;
      if (_p$3 < _p$2) {
        const _p$4 = data[_p$3];
        _p[_p$3] = _p$4._0;
        _tmp = _p$3 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const xs = _p;
    const _p$3 = new Array(data.length);
    const _p$4 = data.length;
    let _tmp$2 = 0;
    while (true) {
      const _p$5 = _tmp$2;
      if (_p$5 < _p$4) {
        const _p$6 = data[_p$5];
        _p$3[_p$5] = _p$6._1;
        _tmp$2 = _p$5 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const ys = _p$3;
    const _bind = _M0FP25Xpeng10mooncharts6extent(xs);
    const _xlo = _bind._0;
    const _xhi = _bind._1;
    const _bind$2 = _M0FP25Xpeng10mooncharts6extent(ys);
    const _ylo_raw = _bind$2._0;
    const _yhi = _bind$2._1;
    const ylo = _ylo_raw > 0 ? 0 : _ylo_raw;
    const _bind$3 = _M0FP25Xpeng10mooncharts11nice__ticks(ylo, _yhi, 5);
    const _axis_lo = _bind$3._0;
    const _axis_hi = _bind$3._1;
    const _ticks = _bind$3._2;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    const n = data.length;
    if (n > 0) {
      const color = _M0MP25Xpeng10mooncharts5Theme9color__at(theme, 0);
      const pts = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      const px_arr = [];
      const py_arr = [];
      let _tmp$3 = 0;
      while (true) {
        const i = _tmp$3;
        if (i < n) {
          const _bind$4 = _M0MPC15array5Array2atGsE(data, i);
          const _x = _bind$4._0;
          const _y = _bind$4._1;
          const px = _M0FP25Xpeng10mooncharts13scale__linear(_x, _xlo, _xhi, 48, 48 + plot_w);
          const py = _M0FP25Xpeng10mooncharts13scale__linear(_y, _axis_lo, _axis_hi, top + plot_h, top);
          _M0MPC15array5Array4pushGdE(px_arr, px);
          _M0MPC15array5Array4pushGdE(py_arr, py);
          if (i > 0) {
            _M0IPB13StringBuilderPB6Logger13write__string(pts, " ");
          }
          _M0IPB13StringBuilderPB6Logger13write__string(pts, `${_M0FP25Xpeng10mooncharts3num(px)},${_M0FP25Xpeng10mooncharts3num(py)}`);
          _tmp$3 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("polyline", [{ _0: "points", _1: pts.val }, _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS961, { _0: "stroke", _1: color }, _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS962, _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS963, _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS964]));
      let _tmp$4 = 0;
      while (true) {
        const i = _tmp$4;
        if (i < n) {
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("circle", [{ _0: "cx", _1: _M0FP25Xpeng10mooncharts3num(_M0MPC15array5Array2atGdE(px_arr, i)) }, { _0: "cy", _1: _M0FP25Xpeng10mooncharts3num(_M0MPC15array5Array2atGdE(py_arr, i)) }, _M0FP25Xpeng10mooncharts19line__chart_2einnerN5tupleS965, { _0: "fill", _1: color }]));
          _tmp$4 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    const _p$5 = "";
    if (!(title === _p$5)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 24, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts26line__chart__multi_2einner(series, title, width, height, theme) {
    const title_h = title === "" ? 8 : 30;
    const top = title_h + 22;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 40;
    const all_x = [];
    const all_y = [];
    const _bind = series.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const s = series[_];
        const _bind$2 = s._1;
        const _bind$3 = _bind$2.length;
        let _tmp$2 = 0;
        while (true) {
          const _$2 = _tmp$2;
          if (_$2 < _bind$3) {
            const p = _bind$2[_$2];
            _M0MPC15array5Array4pushGdE(all_x, p._0);
            _M0MPC15array5Array4pushGdE(all_y, p._1);
            _tmp$2 = _$2 + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const _bind$2 = _M0FP25Xpeng10mooncharts6extent(all_x);
    const _xlo = _bind$2._0;
    const _xhi = _bind$2._1;
    const _bind$3 = _M0FP25Xpeng10mooncharts6extent(all_y);
    const _ylo_raw = _bind$3._0;
    const _yhi = _bind$3._1;
    const ylo = _ylo_raw > 0 ? 0 : _ylo_raw;
    const _bind$4 = _M0FP25Xpeng10mooncharts11nice__ticks(ylo, _yhi, 5);
    const _axis_lo = _bind$4._0;
    const _axis_hi = _bind$4._1;
    const _ticks = _bind$4._2;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    const _bind$5 = series.length;
    let _tmp$2 = 0;
    while (true) {
      const i = _tmp$2;
      if (i < _bind$5) {
        const points = _M0MPC15array5Array2atGsE(series, i)._1;
        const color = _M0MP25Xpeng10mooncharts5Theme9color__at(theme, i);
        const pts = _M0MPB13StringBuilder21StringBuilder_2einner(0);
        const coords = [];
        const _bind$6 = points.length;
        let _tmp$3 = 0;
        while (true) {
          const j = _tmp$3;
          if (j < _bind$6) {
            const _bind$7 = _M0MPC15array5Array2atGsE(points, j);
            const _x = _bind$7._0;
            const _y = _bind$7._1;
            const px = _M0FP25Xpeng10mooncharts13scale__linear(_x, _xlo, _xhi, 48, 48 + plot_w);
            const py = _M0FP25Xpeng10mooncharts13scale__linear(_y, _axis_lo, _axis_hi, top + plot_h, top);
            _M0MPC15array5Array4pushGUsdEE(coords, { _0: px, _1: py });
            if (j > 0) {
              _M0IPB13StringBuilderPB6Logger13write__string(pts, " ");
            }
            _M0IPB13StringBuilderPB6Logger13write__string(pts, `${_M0FP25Xpeng10mooncharts3num(px)},${_M0FP25Xpeng10mooncharts3num(py)}`);
            _tmp$3 = j + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("polyline", [{ _0: "points", _1: pts.val }, _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS966, { _0: "stroke", _1: color }, _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS967, _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS968, _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS969]));
        const _bind$7 = coords.length;
        let _tmp$4 = 0;
        while (true) {
          const _ = _tmp$4;
          if (_ < _bind$7) {
            const c = coords[_];
            _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("circle", [{ _0: "cx", _1: _M0FP25Xpeng10mooncharts3num(c._0) }, { _0: "cy", _1: _M0FP25Xpeng10mooncharts3num(c._1) }, _M0FP25Xpeng10mooncharts26line__chart__multi_2einnerN5tupleS970, { _0: "fill", _1: color }]));
            _tmp$4 = _ + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _tmp$2 = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const legend_items = [];
    const _bind$6 = series.length;
    let _tmp$3 = 0;
    while (true) {
      const i = _tmp$3;
      if (i < _bind$6) {
        _M0MPC15array5Array4pushGUsdEE(legend_items, { _0: _M0MPC15array5Array2atGsE(series, i)._0, _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, i) });
        _tmp$3 = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts18legend__horizontal(legend_items, width / 2, title_h + 14, theme.text));
    const _p = "";
    if (!(title === _p)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 20, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts18bar__chart_2einner(data, title, width, height, theme) {
    const top = title === "" ? 16 : 40;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 48;
    const _p = new Array(data.length);
    const _p$2 = data.length;
    let _tmp = 0;
    while (true) {
      const _p$3 = _tmp;
      if (_p$3 < _p$2) {
        const _p$4 = data[_p$3];
        _p[_p$3] = _p$4._1;
        _tmp = _p$3 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const values = _p;
    const _bind = _M0FP25Xpeng10mooncharts6extent(values);
    const _raw_max = _bind._1;
    const max = _raw_max <= 0 ? 1 : _raw_max;
    const _bind$2 = _M0FP25Xpeng10mooncharts11nice__ticks(0, max, 5);
    const _axis_lo = _bind$2._0;
    const _axis_hi = _bind$2._1;
    const _ticks = _bind$2._2;
    const n = data.length;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    if (n > 0) {
      const slot = plot_w / (n + 0);
      const bar_w = slot * 0.62;
      let _tmp$2 = 0;
      while (true) {
        const i = _tmp$2;
        if (i < n) {
          const _bind$3 = _M0MPC15array5Array2atGsE(data, i);
          const _name = _bind$3._0;
          const _value = _bind$3._1;
          const bar_h = _value / _axis_hi * plot_h;
          const x = 48 + slot * (i + 0) + (slot - bar_w) / 2;
          const y = top + plot_h - bar_h;
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("rect", [{ _0: "x", _1: _M0FP25Xpeng10mooncharts3num(x) }, { _0: "y", _1: _M0FP25Xpeng10mooncharts3num(y) }, { _0: "width", _1: _M0FP25Xpeng10mooncharts3num(bar_w) }, { _0: "height", _1: _M0FP25Xpeng10mooncharts3num(bar_h) }, { _0: "fill", _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, i) }, _M0FP25Xpeng10mooncharts18bar__chart_2einnerN5tupleS971]));
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(x + bar_w / 2, y - 6, _M0FP25Xpeng10mooncharts3num(_value), 11, "middle", "normal", theme.text));
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(x + bar_w / 2, top + plot_h + 16, _name, 11, "middle", "normal", theme.text));
          _tmp$2 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    const _p$3 = "";
    if (!(title === _p$3)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 24, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts27bar__chart__grouped_2einner(categories, series, title, width, height, theme) {
    const title_h = title === "" ? 8 : 30;
    const top = title_h + 22;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 48;
    let raw_max = 0;
    const _bind = series.length;
    let _tmp = 0;
    while (true) {
      const _ = _tmp;
      if (_ < _bind) {
        const s = series[_];
        const _bind$2 = s._1;
        const _bind$3 = _bind$2.length;
        let _tmp$2 = 0;
        while (true) {
          const _$2 = _tmp$2;
          if (_$2 < _bind$3) {
            const v = _bind$2[_$2];
            if (v > raw_max) {
              raw_max = v;
            }
            _tmp$2 = _$2 + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        _tmp = _ + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const max = raw_max <= 0 ? 1 : raw_max;
    const _bind$2 = _M0FP25Xpeng10mooncharts11nice__ticks(0, max, 5);
    const _axis_lo = _bind$2._0;
    const _axis_hi = _bind$2._1;
    const _ticks = _bind$2._2;
    const n_cat = categories.length;
    const n_ser = series.length;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    if (n_cat > 0 && n_ser > 0) {
      const slot = plot_w / (n_cat + 0);
      const group_w = slot * 0.7;
      const bar_w = group_w / (n_ser + 0);
      let _tmp$2 = 0;
      while (true) {
        const c = _tmp$2;
        if (c < n_cat) {
          const group_x = 48 + slot * (c + 0) + (slot - group_w) / 2;
          let _tmp$3 = 0;
          while (true) {
            const s = _tmp$3;
            if (s < n_ser) {
              const values = _M0MPC15array5Array2atGsE(series, s)._1;
              const value = c < values.length ? _M0MPC15array5Array2atGdE(values, c) : 0;
              const bar_h = value / _axis_hi * plot_h;
              const x = group_x + bar_w * (s + 0);
              const y = top + plot_h - bar_h;
              _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("rect", [{ _0: "x", _1: _M0FP25Xpeng10mooncharts3num(x) }, { _0: "y", _1: _M0FP25Xpeng10mooncharts3num(y) }, { _0: "width", _1: _M0FP25Xpeng10mooncharts3num(bar_w) }, { _0: "height", _1: _M0FP25Xpeng10mooncharts3num(bar_h) }, { _0: "fill", _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, s) }, _M0FP25Xpeng10mooncharts27bar__chart__grouped_2einnerN5tupleS972]));
              _tmp$3 = s + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(group_x + group_w / 2, top + plot_h + 16, _M0MPC15array5Array2atGsE(categories, c), 11, "middle", "normal", theme.text));
          _tmp$2 = c + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    const legend_items = [];
    let _tmp$2 = 0;
    while (true) {
      const s = _tmp$2;
      if (s < n_ser) {
        _M0MPC15array5Array4pushGUsdEE(legend_items, { _0: _M0MPC15array5Array2atGsE(series, s)._0, _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, s) });
        _tmp$2 = s + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts18legend__horizontal(legend_items, width / 2, title_h + 14, theme.text));
    const _p = "";
    if (!(title === _p)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 20, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts27bar__chart__stacked_2einner(categories, series, title, width, height, theme) {
    const title_h = title === "" ? 8 : 30;
    const top = title_h + 22;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 48;
    const n_cat = categories.length;
    const n_ser = series.length;
    let raw_max = 0;
    let _tmp = 0;
    while (true) {
      const c = _tmp;
      if (c < n_cat) {
        let total = 0;
        let _tmp$2 = 0;
        while (true) {
          const s = _tmp$2;
          if (s < n_ser) {
            const vals = _M0MPC15array5Array2atGsE(series, s)._1;
            if (c < vals.length) {
              total = total + _M0MPC15array5Array2atGdE(vals, c);
            }
            _tmp$2 = s + 1 | 0;
            continue;
          } else {
            break;
          }
        }
        if (total > raw_max) {
          raw_max = total;
        }
        _tmp = c + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const max = raw_max <= 0 ? 1 : raw_max;
    const _bind = _M0FP25Xpeng10mooncharts11nice__ticks(0, max, 5);
    const _axis_lo = _bind._0;
    const _axis_hi = _bind._1;
    const _ticks = _bind._2;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    if (n_cat > 0 && n_ser > 0) {
      const slot = plot_w / (n_cat + 0);
      const bar_w = slot * 0.6;
      let _tmp$2 = 0;
      while (true) {
        const c = _tmp$2;
        if (c < n_cat) {
          const x = 48 + slot * (c + 0) + (slot - bar_w) / 2;
          let acc = 0;
          let _tmp$3 = 0;
          while (true) {
            const s = _tmp$3;
            if (s < n_ser) {
              const vals = _M0MPC15array5Array2atGsE(series, s)._1;
              const value = c < vals.length ? _M0MPC15array5Array2atGdE(vals, c) : 0;
              if (value > 0) {
                const seg_h = value / _axis_hi * plot_h;
                const y = top + plot_h - acc / _axis_hi * plot_h - seg_h;
                _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("rect", [{ _0: "x", _1: _M0FP25Xpeng10mooncharts3num(x) }, { _0: "y", _1: _M0FP25Xpeng10mooncharts3num(y) }, { _0: "width", _1: _M0FP25Xpeng10mooncharts3num(bar_w) }, { _0: "height", _1: _M0FP25Xpeng10mooncharts3num(seg_h) }, { _0: "fill", _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, s) }]));
                acc = acc + value;
              }
              _tmp$3 = s + 1 | 0;
              continue;
            } else {
              break;
            }
          }
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(x + bar_w / 2, top + plot_h + 16, _M0MPC15array5Array2atGsE(categories, c), 11, "middle", "normal", theme.text));
          _tmp$2 = c + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    const legend_items = [];
    let _tmp$2 = 0;
    while (true) {
      const s = _tmp$2;
      if (s < n_ser) {
        _M0MPC15array5Array4pushGUsdEE(legend_items, { _0: _M0MPC15array5Array2atGsE(series, s)._0, _1: _M0MP25Xpeng10mooncharts5Theme9color__at(theme, s) });
        _tmp$2 = s + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts18legend__horizontal(legend_items, width / 2, title_h + 14, theme.text));
    const _p = "";
    if (!(title === _p)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 20, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP25Xpeng10mooncharts19area__chart_2einner(data, title, width, height, theme) {
    const top = title === "" ? 16 : 40;
    const plot_w = width - 48 - 16;
    const plot_h = height - top - 40;
    const _p = new Array(data.length);
    const _p$2 = data.length;
    let _tmp = 0;
    while (true) {
      const _p$3 = _tmp;
      if (_p$3 < _p$2) {
        const _p$4 = data[_p$3];
        _p[_p$3] = _p$4._0;
        _tmp = _p$3 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const xs = _p;
    const _p$3 = new Array(data.length);
    const _p$4 = data.length;
    let _tmp$2 = 0;
    while (true) {
      const _p$5 = _tmp$2;
      if (_p$5 < _p$4) {
        const _p$6 = data[_p$5];
        _p$3[_p$5] = _p$6._1;
        _tmp$2 = _p$5 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const ys = _p$3;
    const _bind = _M0FP25Xpeng10mooncharts6extent(xs);
    const _xlo = _bind._0;
    const _xhi = _bind._1;
    const _bind$2 = _M0FP25Xpeng10mooncharts6extent(ys);
    const _ylo_raw = _bind$2._0;
    const _yhi = _bind$2._1;
    const ylo = _ylo_raw > 0 ? 0 : _ylo_raw;
    const _bind$3 = _M0FP25Xpeng10mooncharts11nice__ticks(ylo, _yhi, 5);
    const _axis_lo = _bind$3._0;
    const _axis_hi = _bind$3._1;
    const _ticks = _bind$3._2;
    const baseline = top + plot_h;
    const body = _M0MPB13StringBuilder21StringBuilder_2einner(0);
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts16background__rect(theme, width, height));
    _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts7y__axis(theme, 48, top, plot_w, plot_h, _axis_lo, _axis_hi, _ticks));
    const n = data.length;
    if (n > 0) {
      const color = _M0MP25Xpeng10mooncharts5Theme9color__at(theme, 0);
      const line_pts = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      const px_arr = [];
      const py_arr = [];
      let _tmp$3 = 0;
      while (true) {
        const i = _tmp$3;
        if (i < n) {
          const _bind$4 = _M0MPC15array5Array2atGsE(data, i);
          const _x = _bind$4._0;
          const _y = _bind$4._1;
          const px = _M0FP25Xpeng10mooncharts13scale__linear(_x, _xlo, _xhi, 48, 48 + plot_w);
          const py = _M0FP25Xpeng10mooncharts13scale__linear(_y, _axis_lo, _axis_hi, baseline, top);
          _M0MPC15array5Array4pushGdE(px_arr, px);
          _M0MPC15array5Array4pushGdE(py_arr, py);
          if (i > 0) {
            _M0IPB13StringBuilderPB6Logger13write__string(line_pts, " ");
          }
          _M0IPB13StringBuilderPB6Logger13write__string(line_pts, `${_M0FP25Xpeng10mooncharts3num(px)},${_M0FP25Xpeng10mooncharts3num(py)}`);
          _tmp$3 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
      const poly = _M0MPB13StringBuilder21StringBuilder_2einner(0);
      _M0IPB13StringBuilderPB6Logger13write__string(poly, `${_M0FP25Xpeng10mooncharts3num(_M0MPC15array5Array2atGdE(px_arr, 0))},${_M0FP25Xpeng10mooncharts3num(baseline)} `);
      _M0IPB13StringBuilderPB6Logger13write__string(poly, line_pts.val);
      _M0IPB13StringBuilderPB6Logger13write__string(poly, ` ${_M0FP25Xpeng10mooncharts3num(_M0MPC15array5Array2atGdE(px_arr, n - 1 | 0))},${_M0FP25Xpeng10mooncharts3num(baseline)}`);
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("polygon", [{ _0: "points", _1: poly.val }, { _0: "fill", _1: color }, _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS973]));
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("polyline", [{ _0: "points", _1: line_pts.val }, _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS974, { _0: "stroke", _1: color }, _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS975, _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS976, _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS977]));
      let _tmp$4 = 0;
      while (true) {
        const i = _tmp$4;
        if (i < n) {
          _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts4elem("circle", [{ _0: "cx", _1: _M0FP25Xpeng10mooncharts3num(_M0MPC15array5Array2atGdE(px_arr, i)) }, { _0: "cy", _1: _M0FP25Xpeng10mooncharts3num(_M0MPC15array5Array2atGdE(py_arr, i)) }, _M0FP25Xpeng10mooncharts19area__chart_2einnerN5tupleS978, { _0: "fill", _1: color }]));
          _tmp$4 = i + 1 | 0;
          continue;
        } else {
          break;
        }
      }
    }
    const _p$5 = "";
    if (!(title === _p$5)) {
      _M0IPB13StringBuilderPB6Logger13write__string(body, _M0FP25Xpeng10mooncharts13label_2einner(width / 2, 24, title, 16, "middle", "bold", theme.title));
    }
    return _M0FP25Xpeng10mooncharts8document(width, height, body.val);
  }
  function _M0FP35Xpeng10mooncharts3web6render(kind, labels, values, dark) {
    const theme = dark ? _M0MP25Xpeng10mooncharts5Theme4dark() : _M0MP25Xpeng10mooncharts5Theme5light();
    const data = [];
    const xy = [];
    const _bind = labels.length;
    let _tmp = 0;
    while (true) {
      const i = _tmp;
      if (i < _bind) {
        const v = i < values.length ? _M0MPC15array5Array2atGdE(values, i) : 0;
        _M0MPC15array5Array4pushGUsdEE(data, { _0: _M0MPC15array5Array2atGsE(labels, i), _1: v });
        _M0MPC15array5Array4pushGUsdEE(xy, { _0: i + 0, _1: v });
        _tmp = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const _p = new Array(values.length);
    const _p$2 = values.length;
    let _tmp$2 = 0;
    while (true) {
      const _p$3 = _tmp$2;
      if (_p$3 < _p$2) {
        const _p$4 = values[_p$3];
        _p[_p$3] = _p$4 * 0.6 + 12;
        _tmp$2 = _p$3 + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const values2 = _p;
    const xy2 = [];
    const _bind$2 = values2.length;
    let _tmp$3 = 0;
    while (true) {
      const i = _tmp$3;
      if (i < _bind$2) {
        _M0MPC15array5Array4pushGUsdEE(xy2, { _0: i + 0, _1: _M0MPC15array5Array2atGdE(values2, i) });
        _tmp$3 = i + 1 | 0;
        continue;
      } else {
        break;
      }
    }
    const two = [{ _0: "Series 1", _1: values }, { _0: "Series 2", _1: values2 }];
    switch (kind) {
      case "line": {
        return _M0FP25Xpeng10mooncharts19line__chart_2einner(xy, "", 640, 380, theme);
      }
      case "area": {
        return _M0FP25Xpeng10mooncharts19area__chart_2einner(xy, "", 640, 380, theme);
      }
      case "scatter": {
        return _M0FP25Xpeng10mooncharts22scatter__chart_2einner(xy, "", 640, 380, 4, theme);
      }
      case "pie": {
        return _M0FP25Xpeng10mooncharts18pie__chart_2einner(data, "", 640, 380, 0, theme);
      }
      case "donut": {
        return _M0FP25Xpeng10mooncharts18pie__chart_2einner(data, "", 640, 380, 0.55, theme);
      }
      case "multiline": {
        return _M0FP25Xpeng10mooncharts26line__chart__multi_2einner([{ _0: "Series 1", _1: xy }, { _0: "Series 2", _1: xy2 }], "", 640, 380, theme);
      }
      case "grouped": {
        return _M0FP25Xpeng10mooncharts27bar__chart__grouped_2einner(labels, two, "", 640, 380, theme);
      }
      case "stacked": {
        return _M0FP25Xpeng10mooncharts27bar__chart__stacked_2einner(labels, two, "", 640, 380, theme);
      }
      case "radar": {
        return _M0FP25Xpeng10mooncharts20radar__chart_2einner(labels, two, "", 640, 380, theme);
      }
      default: {
        return _M0FP25Xpeng10mooncharts18bar__chart_2einner(data, "", 640, 380, theme);
      }
    }
  }
  globalThis.render = _M0FP35Xpeng10mooncharts3web6render;
})();
