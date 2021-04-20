/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 * 
 * with our changes that are developed for staking 
 */
 pragma solidity ^0.8.1;
 
 abstract contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping (address => uint256) private _balances;
    mapping (address => uint256) private _freez;
    mapping (address => mapping (uint256 => uint256)) private _stakeDate;
    mapping (address => mapping (uint256 => mapping (uint256 => uint256))) private _rewardCoefficients;
    mapping (address => mapping (uint256 => string)) private _contract;
    mapping (address => mapping (uint256 => mapping (uint256 => uint256))) private _rewardTimes;
    mapping (address => mapping (uint256 => mapping (uint256 => uint256))) private _rewardValues;
    mapping (address => mapping (uint256  => mapping (uint256 => uint256))) private _payed;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    uint256 _decimals;
    string private _name;
    string private _symbol;
    uint256 private _monthSeconds;
    /*Seconds for computing on Periods*/
    uint32 _yearSeconds;
    uint256 _startSupply;
    uint256 _stake;
    uint256 _deployTime;
    uint256 _maximumcoin;
    
    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    
    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _decimals=10**8;
        _maximumcoin=11199163*_decimals;
        _yearSeconds=31540000;
        _monthSeconds=2628000;
        _deployTime=block.timestamp;
    }
    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

 
  
    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer} , {ARIX-stake}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
   function totalSupply() public view virtual override  returns(uint256) {
        uint256 _elapsetime = block.timestamp.sub(_deployTime);
        uint256 _valyear=_decimals;
        if(_elapsetime <=4){      
            if((_elapsetime) * 500000 * _decimals < _maximumcoin)
                return ((_elapsetime) * 500000 *_decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime>4 && _elapsetime <=_yearSeconds)
        {
             if((_elapsetime/600)* 50 *_decimals < _maximumcoin)
                return _valyear=_valyear+((_elapsetime/600) * 50 * _decimals)+ (2000000 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime>_yearSeconds && _elapsetime<= 2*_yearSeconds)
        {
              if((_elapsetime/600)* 25 *_decimals < _maximumcoin)
                return _valyear=_valyear+((_elapsetime/600) * 25* _decimals)+ (4628333 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 2*_yearSeconds && _elapsetime<= 3*_yearSeconds){
            if(((_elapsetime/600)* 125 *_decimals)/10 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 125 *_decimals)/10)+ (5942500 * _decimals);
            else
            return(_maximumcoin);
           
        }else if(_elapsetime > 3*_yearSeconds && _elapsetime<= 4*_yearSeconds)
        {
            if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)*625 *_decimals)/100)+ (6599583 * _decimals);
            else
            return(_maximumcoin);
            
        }else if(_elapsetime > 4*_yearSeconds && _elapsetime<=5* _yearSeconds)
        {
             if(((_elapsetime/600)* 625*_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (6928124 * _decimals);
            else
            return(_maximumcoin);
        
        }else if(_elapsetime > 5* _yearSeconds && _elapsetime<=6* _yearSeconds)
        {
            if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (7256666 * _decimals);
            else
            return(_maximumcoin);
            
        }else if(_elapsetime > 6* _yearSeconds && _elapsetime<=7* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (7585207 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 7* _yearSeconds && _elapsetime<=8* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (7913750 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 8* _yearSeconds && _elapsetime<=9* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (8242290 * _decimals);
            else
            return(_maximumcoin);
        }
        else if(_elapsetime > 9* _yearSeconds && _elapsetime<=10* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (8570832 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 10* _yearSeconds && _elapsetime<=11* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (8892372 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 11* _yearSeconds && _elapsetime<=12* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (9227214 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 12* _yearSeconds && _elapsetime<=13* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (9556455 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 13* _yearSeconds && _elapsetime<=14* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (9884997 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 14* _yearSeconds && _elapsetime<=15* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (10213538 * _decimals);
            else
            return(_maximumcoin);
        }else if(_elapsetime > 15* _yearSeconds && _elapsetime<16* _yearSeconds)
        {
           if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (10542080 * _decimals);
            else
            return(_maximumcoin);
        } else if(_elapsetime >= 16* _yearSeconds && _elapsetime<17* _yearSeconds)
        { 
            if(((_elapsetime/600)* 625 *_decimals)/100 < _maximumcoin)
                return _valyear=_valyear+(((_elapsetime/600)* 625 *_decimals)/100)+ (10870621 * _decimals);
            else
            return(_maximumcoin);
         
        }else if(_elapsetime >= 17* _yearSeconds) {
             return _valyear+=11199163 * _decimals;
            
        }else{
            return 11199163 * _decimals;
        }
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
    
    /**
     * @dev See {IERC20-freezOf}.
     */
      function freezOf(address account) public view virtual override returns (uint256) {
        return _freez[account];
    }
    /**
     * @dev See {IERC20-contractOf}.
     */
  
    function contractOf(address account,uint256 stakeTime) public view virtual override returns (string memory) {
        return _contract[account][stakeTime];
     }
    /**
     * @dev See {IERC20-payedOf}.
     */
    function payedOf(address account,uint256 stakeTime,uint256 _rewardTime) public view virtual override returns (uint256) {
        return _payed[account][stakeTime][_rewardTime];
    }
     /**
     * @dev See {IERC20-stakedateOf}.
     */
    function stakedateOf(address account,uint256 index) public view virtual override returns (uint256) {
        return _stakeDate[account][index];
    }
     /**
     * @dev See {IERC20-deployTimeOf}.
     */
     function deployTimeOf() public view virtual override returns (uint256) {
        return _deployTime;
    }
      /**
     * @dev See {IERC20-currentTimeOf}.
     */
     function currentTimeOf() public view virtual override returns (uint256) {
        return block.timestamp;
    }
      /**
     * @dev See {IERC20-RewardCoefficientsOf}.
     */
     function RewardCoefficientsOf(address _stakeAddress,uint256 _stakeStartTime,uint256 _rewardTime) public view virtual override returns (uint256) {
        return _rewardCoefficients[_stakeAddress][_stakeStartTime][_rewardTime];
    }
      /**
     * @dev See {IERC20-RewardValuesOf}.
     */
     function RewardValuesOf(address _stakeAddress,uint256 _stakeStartTime,uint256 _rewardTime) public view virtual override returns (uint256) {
        return _rewardValues[_stakeAddress][_stakeStartTime][_rewardTime];
    }
     /**
     * @dev See {IERC20-RewardTimesOf}.
     */
     function RewardTimesOf(address _stakeAddress,uint256 _stakeStartTime,uint256 index) public view virtual override returns (uint256) {
        return _rewardTimes[_stakeAddress][_stakeStartTime][index];
    }
    
    
    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
         require(amount <= totalSupply(), "ERC20: Only less than total released can be tranfered");
         require(_balances[_msgSender()]-_freez[_msgSender()]>= amount,"ERC20: cant transfer more than freez");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }



    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
         
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
         require(_balances[sender]-_freez[sender]>= amount,"ERC20: cant transfer more than freez");
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        return true;
    }
    

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) public virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_balances[sender]-_freez[sender]>= amount,"ARIX: cant transfer more than freez");
        _beforeTokenTransfer(sender, recipient, amount);
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }
    
 using SafeMath for uint256;
    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     */
   
     
    function _mint(address account, uint256 amount) internal virtual  {
        require(account != address(0), "ERC20: mint to the zero address");
        _beforeTokenTransfer(address(0), account, amount);
       _balances[account] += amount * _decimals;
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account == address(0), "ERC20: burn from the zero address");
        require(_balances[account]-_freez[account]>= amount,"ERC20: cant transfer more than freez");
        _beforeTokenTransfer(account, address(0), amount);
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);
    }
    
    function _freezSet(uint256 _amount,address _stakeAddress)  internal virtual {
   
        _freez[_stakeAddress]+=_amount;
   
    }

    function _contractset(address account,uint256 stakeTime,string memory _contractType) internal virtual {
         _contract[account][stakeTime]=_contractType;
    }

    /** 
     * @dev   calculate Stake RewardTimes Assign Coefficients `_stakeAddress`
     * and calculate stake reward Coefficients for this stake address
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     */
    function _calculateStakeRewardTimesAssignCoefficients(address _stakeAddress,uint256 _stakeStartTime) internal virtual
    {
         for(uint256 indexTime=1;indexTime<13;indexTime++){
                  _rewardTimes[_stakeAddress][_stakeStartTime][indexTime]= _stakeStartTime + (indexTime * _monthSeconds);
         }
         for(uint256 indexReward=1;indexReward<=13;indexReward++){
                _calculateStakeRewardCoefitient(_stakeAddress,_stakeStartTime, _stakeStartTime + (indexReward * _monthSeconds));
         }
    }
     /** 
     * @dev  calculate Stake Reward Coefficients  `_stakeAddress` and '_stakeStartTime','_rewardTime'
     * and calculate stake reward Coefficients for this stake address
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     * - `_rewardTime` calculate from `_stakeStartTime`.
     *  for detailes you can find tutorials in  aricCoin.io
     */
    function _calculateStakeRewardCoefitient(address _stakeAddress,uint256 _stakeStartTime,uint256 _rewardTime) internal virtual
    {
     require(_stakeAddress != address(0), "ERC20: mint to the zero address");
     require(_rewardTime > _deployTime,"ARIX : require Reward > deployTime");
     uint256 _elapsetime=(_rewardTime.sub(_deployTime));
     uint256 _Coefficient=1;
     
        if(_elapsetime>0 && _elapsetime <= 6 * _monthSeconds)
        {
              _Coefficient=_Coefficient * _decimals *  1;
        }else if(_elapsetime>6 * _monthSeconds && _elapsetime<= (_yearSeconds + (6 * _monthSeconds)))
        {
              _Coefficient=(_Coefficient * _decimals  * 5)/(10 );
        }else if(_elapsetime > (_yearSeconds + (6 * _monthSeconds)) && _elapsetime<= (2*_yearSeconds + (6 * _monthSeconds))){
            _Coefficient=(_Coefficient * _decimals  * 25)/(100);
           
        }
        else if(_elapsetime > (2*_yearSeconds + (6 * _monthSeconds))  && _elapsetime<= (3*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 125)/(1000);
            
        }else if(_elapsetime > (3*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(4*_yearSeconds + (6 * _monthSeconds)))
        {
             _Coefficient=(_Coefficient * _decimals  * 625)/10000;
        
        }else if(_elapsetime > (4*_yearSeconds + (6 * _monthSeconds))  && _elapsetime<=(5*_yearSeconds + (6 * _monthSeconds)))
        {
            _Coefficient=(_Coefficient * _decimals  * 3125)/(100000);
            
        }else if(_elapsetime > (5*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(6*_yearSeconds + (6 * _monthSeconds)))
        {
             _Coefficient=(_Coefficient * _decimals  * 15625)/(1000000);
        }else if(_elapsetime > (6*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(7*_yearSeconds + (6 * _monthSeconds)))
        {
            _Coefficient=(_Coefficient  * _decimals  * 78125)/(10000000);
        }else if(_elapsetime > (7*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(8*_yearSeconds + (6 * _monthSeconds)))
        {
             _Coefficient=(_Coefficient * _decimals  * 390625)/(100000000);
        }
        else if(_elapsetime > (8*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(9*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 195312)/(100000000);
        }else if(_elapsetime > (9*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(10*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 97656)/(100000000);
        }else if(_elapsetime > (10*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(11*_yearSeconds + (6 * _monthSeconds)))
        {
          _Coefficient=(_Coefficient * _decimals  * 48828)/(100000000);
        }else if(_elapsetime > (11*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(12*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 24414)/(100000000);
        }else if(_elapsetime > (12*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(13*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 12207)/(100000000); 
        }else if(_elapsetime > (13*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(14*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 6104)/(100000000 );
        }else if(_elapsetime > (14*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(15*_yearSeconds + (6 * _monthSeconds)))
        {
           _Coefficient=(_Coefficient * _decimals  * 3052)/(100000000);
        } else if(_elapsetime > (15*_yearSeconds + (6 * _monthSeconds)) && _elapsetime<=(16*_yearSeconds + (6 * _monthSeconds)) )
        {
           _Coefficient=(_Coefficient * _decimals  * 1526)/(100000000);
        }else{
          _Coefficient=(_Coefficient * _decimals  * 1526)/(100000000);
        }
        _rewardCoefficients[_stakeAddress][_stakeStartTime][_rewardTime]=_Coefficient;
}
 /** 
     * @dev  calculate  Reward stake list  with `_stakeAddress` and '_stakeStartTime','_rewardTime'
     * and calculate stake reward Coefficients for this stake address
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     * - `_stakeAmount` input stake amount.
     * - `_rewardTime` calculate from `_stakeStartTime` amount.
     * -for detailes you can find tutorials on  arixCoin.io
     */
function _calculateRewardStakelist(address _stakeAddress,uint256 _stakeStartTime,uint256 _stakeAmount,uint256 _rewardTime)  internal virtual 
{
          require(5<=_stakeAmount , "ARIX: less than 5 tokens are not possible.");
          uint256 rewardCof=_rewardCoefficients[_stakeAddress][_stakeStartTime][_rewardTime];
          
           if( 5*_decimals<=_stakeAmount && _stakeAmount<=19*_decimals)
           {
               _rewardValues[_stakeAddress][_stakeStartTime][_rewardTime]= rewardCof * (_stakeAmount   * 5)/(1000*_decimals);
           }else if(20*_decimals<=_stakeAmount && _stakeAmount<=100*_decimals)
           {
              _rewardValues[_stakeAddress][_stakeStartTime][_rewardTime] = rewardCof * (_stakeAmount  * 11)/(1000*_decimals);
           }else if(101*_decimals<= _stakeAmount && _stakeAmount<=200*_decimals)
           {
             _rewardValues[_stakeAddress][_stakeStartTime][_rewardTime]= rewardCof * (_stakeAmount  * 18)/(1000*_decimals);
           }else if(201*_decimals<=_stakeAmount && _stakeAmount<=500*_decimals)
           {
              _rewardValues[_stakeAddress][_stakeStartTime][_rewardTime]= rewardCof * (_stakeAmount  * 25)/(1000*_decimals);
           }else if(501*_decimals<=_stakeAmount)
           {
              _rewardValues[_stakeAddress][_stakeStartTime][_rewardTime]= rewardCof * (_stakeAmount  * 3)/(100*_decimals);
           }
}
/** 
     * @dev  initialing stake storages happen with  `_stakeAddress` and '_stakeStartTime','_stakeAmount'
     * 
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     * - `_stakeAmount` input stake amount.
     * - 
     * - for detailes you can find tutorials on  arixCoin.io
*/
function _setStake(address _StakeAddress,uint256 _stakeStartTime,uint256 _stakeAmount) internal virtual returns(bool)
{
       _calculateStakeRewardTimesAssignCoefficients(_StakeAddress,_stakeStartTime);
     for(uint256 index=1;index<=13;index++){
         _calculateRewardStakelist(_StakeAddress,_stakeStartTime,_stakeAmount,_rewardTimes[_StakeAddress][_stakeStartTime][index]);
     }
    return true;
}
/** 
     * @dev  pay stake rewards with  `_stakeAddress` and '_stakeStartTime','_rewardTime'
     * 
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     * - `_rewardTime` calculate  from `_stakeStartTime` with `_calculateStakeRewardTimesAssignCoefficients`.
     * - 
     * - for detailes you can find tutorials on  arixCoin.io
*/
function _RewardPay(address _StakeAddress,uint256 _StakeStartTime,uint256 _rewardTime) public virtual
{
      
      require(balanceOf(_StakeAddress)-freezOf(_StakeAddress)>= _rewardValues[_StakeAddress][_StakeStartTime][_rewardTime],"ARIX: cant transfer more than freez");
      require(payedOf(_StakeAddress,_StakeStartTime,_rewardTime)!= _rewardValues[_StakeAddress][_StakeStartTime][_rewardTime],"ARIX: cant transfer Payed Value");
      _payedSet(_StakeAddress,_StakeStartTime,_rewardTime,_rewardValues[_StakeAddress][_StakeStartTime][_rewardTime]);
      emit Transfer(address(0),_StakeAddress,_rewardValues[_StakeAddress][_StakeStartTime][_rewardTime]);
}
/** 
     * @dev  pay stake rewards with  `_stakeAddress` and '_stakeStartTime','index'
     * 
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     * - `index` calculate  from dapp.
     * - 
     * - for detailes you can find tutorials on  arixCoin.io
*/
function _stakeTimeSet(address _stakeAddress,uint256 _stakeStartTime,uint256 index) internal  virtual {
    _stakeDate[_stakeAddress][index]=_stakeStartTime;
}
/** 
     * @dev  remove freez after oner year stakeTime
     * inputs `_stakeAddress` and 'index'
     * 
     *
     * Requirements:
     *
     * - `_stakeAddress` cannot be the zero address.
     * 
     * - `index` calculate  from dapp.
     * - 
     * - for detailes you can find tutorials on  arixCoin.io
*/
function _removeFreez(address _stakeAddress,uint256 index) public  virtual {
   require(_stakeAddress != address(0), "ARIX: approve from the zero address");
   require(block.timestamp- _stakeDate[_stakeAddress][index]>_yearSeconds,"ARIX: Freez time didnt finish!" );
    _freez[_stakeAddress]=0;
}

/** 
     * @dev payed Rewards initial 
     * 
     * inputs `account` and 'stakeTime','_rewardTime','_payeds'
     * 
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `_stakeStartTime` must have at least `time stamp` value.
     * - `_rewardTime` calculate from '_stakeStartTime'.
     * - `_payeds` rewards to account
     * - for detailes you can find tutorials on  arixCoin.io
*/
function _payedSet(address account,uint256 stakeTime,uint256 _rewardTime,uint256 _payeds) internal virtual {
        require(account != address(0), "ARIX: approve from the zero address");
         _payed[account][stakeTime][_rewardTime]=_payeds;
    }
    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ARIX: approve from the zero address");
        require(spender != address(0), "ARIX: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }


    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}
