[38;2;117;113;94m#[0m[38;2;117;113;94m IndividuallyCappedCrowdsale[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m Contributors: Binod Nirvan[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m This file is released under Apache 2.0 license.[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m @dev Crowdsale with a limit for total contributions.[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m Ported from Open Zeppelin[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m https://github.com/OpenZeppelin[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m [0m
[38;2;117;113;94m#[0m[38;2;117;113;94m See https://github.com/OpenZeppelin[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m Open Zeppelin tests ported: Crowdsale.test.js[0m


[38;2;117;113;94m#[0m[38;2;117;113;94m@dev ERC20/223 Features referenced by this contract[0m
[38;2;249;38;114mcontract[0m[38;2;248;248;242m [0m[4;38;2;102;217;239mTokenContract[0m[38;2;249;38;114m:[0m
[38;2;248;248;242m    [0m[3;38;2;102;217;239mdef[0m[38;2;248;248;242m [0m[38;2;166;226;46mtransfer[0m[38;2;248;248;242m([0m[3;38;2;253;151;31m_to[0m[38;2;248;248;242m: [0m[38;2;190;132;255maddress[0m[38;2;248;248;242m, [0m[3;38;2;253;151;31m_value[0m[38;2;248;248;242m: [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m)[0m[38;2;248;248;242m [0m[38;2;249;38;114m->[0m[38;2;248;248;242m [0m[38;2;190;132;255mbool[0m[38;2;249;38;114m:[0m[38;2;248;248;242m modifying[0m

[38;2;117;113;94m#[0m[38;2;117;113;94m Event for token purchase logging[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m @param _purchaser who paid for the tokens[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m @param _beneficiary who got the tokens[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m @param _value weis paid for purchase[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m @param _amount amount of tokens purchased[0m
[38;2;248;248;242mTokenPurchase[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mevent[0m[38;2;248;248;242m([0m[38;2;248;248;242m{_purchaser[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mindexed[0m[38;2;248;248;242m([0m[38;2;190;132;255maddress[0m[38;2;248;248;242m)[0m[38;2;248;248;242m, _beneficiary[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mindexed[0m[38;2;248;248;242m([0m[38;2;190;132;255maddress[0m[38;2;248;248;242m)[0m[38;2;248;248;242m, _value[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m(wei[0m[38;2;248;248;242m)[0m[38;2;248;248;242m, _amount[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m})[0m

[38;2;117;113;94m#[0m[38;2;117;113;94m The token being sold[0m
[38;2;248;248;242mtoken[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mpublic[0m[38;2;248;248;242m([0m[38;2;190;132;255maddress[0m[38;2;248;248;242m)[0m

[38;2;117;113;94m#[0m[38;2;117;113;94mAddress where funds are collected[0m
[38;2;248;248;242mwallet[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mpublic[0m[38;2;248;248;242m([0m[38;2;190;132;255maddress[0m[38;2;248;248;242m)[0m

[38;2;117;113;94m#[0m[38;2;117;113;94m How many token units a buyer gets per wei.[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m The rate is the conversion between wei and the smallest and indivisible token unit.[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m So, if you are using a rate of 1 with a DetailedERC20 token with 3 decimals called TOK[0m
[38;2;117;113;94m#[0m[38;2;117;113;94m 1 wei will give you 1 unit, or 0.001 TOK.[0m
[38;2;248;248;242mrate[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mpublic[0m[38;2;248;248;242m([0m[38;2;190;132;255muint256[0m[38;2;248;248;242m)[0m

[38;2;117;113;94m#[0m[38;2;117;113;94mAmount of wei raised[0m
[38;2;248;248;242mweiRaised[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;102;217;239mpublic[0m[38;2;248;248;242m([0m[38;2;190;132;255muint256[0m[38;2;248;248;242m(wei[0m[38;2;248;248;242m)[0m[38;2;248;248;242m)[0m

[38;2;249;38;114m@public[0m
[3;38;2;102;217;239mdef[0m[38;2;248;248;242m [0m[38;2;166;226;46m__init__[0m[38;2;248;248;242m([0m[3;38;2;253;151;31m_rate[0m[38;2;248;248;242m: [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m, [0m[3;38;2;253;151;31m_wallet[0m[38;2;248;248;242m: [0m[38;2;190;132;255maddress[0m[38;2;248;248;242m, [0m[3;38;2;253;151;31m_token[0m[38;2;248;248;242m: [0m[38;2;190;132;255maddress[0m[38;2;248;248;242m)[0m[38;2;249;38;114m:[0m
[38;2;248;248;242m    [0m[38;2;117;113;94m"""[0m
[38;2;117;113;94m    [0m[38;2;230;219;116m@dev[0m[38;2;117;113;94m Initializes this contract[0m
[38;2;117;113;94m    [0m[38;2;230;219;116m@param[0m[38;2;117;113;94m _rate Number of token units a buyer gets per wei[0m
[38;2;117;113;94m    [0m[38;2;230;219;116m@param[0m[38;2;117;113;94m _wallet Address where collected funds will be forwarded to[0m
[38;2;117;113;94m    [0m[38;2;230;219;116m@param[0m[38;2;117;113;94m _token Address of the token being sold[0m
[38;2;117;113;94m    [0m[38;2;117;113;94m"""[0m

[38;2;248;248;242m    [0m[38;2;249;38;114massert[0m[38;2;248;248;242m _rate [0m[38;2;249;38;114m>[0m[38;2;248;248;242m [0m[38;2;190;132;255m0[0m[38;2;248;248;242m, [0m[38;2;230;219;116m"Invalid value supplied for the parameter \"[0m[38;2;248;248;242m_rate\[0m[38;2;230;219;116m"."[0m
[38;2;248;248;242m    [0m[38;2;249;38;114massert[0m[38;2;248;248;242m _wallet [0m[38;2;249;38;114m!=[0m[38;2;248;248;242m ZERO_ADDRESS, [0m[38;2;230;219;116m"Invalid wallet address."[0m
[38;2;248;248;242m    [0m[38;2;249;38;114massert[0m[38;2;248;248;242m _token [0m[38;2;249;38;114m!=[0m[38;2;248;248;242m ZERO_ADDRESS, [0m[38;2;230;219;116m"Invalid token address."[0m

[38;2;248;248;242m    [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.rate [0m[38;2;249;38;114m=[0m[38;2;248;248;242m _rate[0m
[38;2;248;248;242m    [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.wallet [0m[38;2;249;38;114m=[0m[38;2;248;248;242m _wallet[0m
[38;2;248;248;242m    [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.token [0m[38;2;249;38;114m=[0m[38;2;248;248;242m _token[0m

[38;2;249;38;114m@private[0m
[38;2;249;38;114m@constant[0m
[3;38;2;102;217;239mdef[0m[38;2;248;248;242m [0m[38;2;166;226;46mgetTokenAmount[0m[38;2;248;248;242m([0m[3;38;2;253;151;31m_weiAmount[0m[38;2;248;248;242m: [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m)[0m[38;2;248;248;242m [0m[38;2;249;38;114m->[0m[38;2;248;248;242m [0m[38;2;190;132;255muint256[0m[38;2;249;38;114m:[0m
[38;2;248;248;242m    [0m[38;2;249;38;114mreturn[0m[38;2;248;248;242m _weiAmount [0m[38;2;249;38;114m*[0m[38;2;248;248;242m [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.rate[0m


[38;2;249;38;114m@private[0m
[3;38;2;102;217;239mdef[0m[38;2;248;248;242m [0m[38;2;166;226;46mprocessTransaction[0m[38;2;248;248;242m([0m[3;38;2;253;151;31m_sender[0m[38;2;248;248;242m: [0m[38;2;190;132;255maddress[0m[38;2;248;248;242m, [0m[3;38;2;253;151;31m_beneficiary[0m[38;2;248;248;242m: [0m[38;2;190;132;255maddress[0m[38;2;248;248;242m, [0m[3;38;2;253;151;31m_weiAmount[0m[38;2;248;248;242m: [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m([0m[38;2;248;248;242mwei[0m[38;2;248;248;242m)[0m[38;2;248;248;242m)[0m[38;2;249;38;114m:[0m
[38;2;248;248;242m    [0m[38;2;117;113;94m#[0m[38;2;117;113;94mpre validate[0m
[38;2;248;248;242m    [0m[38;2;249;38;114massert[0m[38;2;248;248;242m _beneficiary [0m[38;2;249;38;114m!=[0m[38;2;248;248;242m ZERO_ADDRESS, [0m[38;2;230;219;116m"Invalid address."[0m
[38;2;248;248;242m    [0m[38;2;249;38;114massert[0m[38;2;248;248;242m _weiAmount [0m[38;2;249;38;114m!=[0m[38;2;248;248;242m [0m[38;2;190;132;255m0[0m[38;2;248;248;242m, [0m[38;2;230;219;116m"Invalid amount received."[0m

[38;2;248;248;242m    [0m[38;2;117;113;94m#[0m[38;2;117;113;94mcalculate the number of tokens for the Ether contribution.[0m
[38;2;248;248;242m    tokens[0m[38;2;249;38;114m:[0m[38;2;248;248;242m [0m[38;2;190;132;255muint256[0m[38;2;248;248;242m [0m[38;2;249;38;114m=[0m[38;2;248;248;242m [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.[0m[38;2;102;217;239mgetTokenAmount[0m[38;2;248;248;242m([0m[38;2;102;217;239mas_unitless_number[0m[38;2;248;248;242m([0m[38;2;248;248;242m_weiAmount[0m[38;2;248;248;242m)[0m[38;2;248;248;242m)[0m
[38;2;248;248;242m    [0m
[38;2;248;248;242m    [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.weiRaised [0m[38;2;249;38;114m+[0m[38;2;249;38;114m=[0m[38;2;248;248;242m _weiAmount[0m

[38;2;248;248;242m    [0m[38;2;117;113;94m#[0m[38;2;117;113;94mprocess purchase[0m
[38;2;248;248;242m    [0m[38;2;249;38;114massert[0m[38;2;248;248;242m [0m[38;2;102;217;239mTokenContract[0m[38;2;248;248;242m([0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.token[0m[38;2;248;248;242m)[0m[38;2;248;248;242m.[0m[38;2;102;217;239mtransfer[0m[38;2;248;248;242m([0m[38;2;248;248;242m_beneficiary, tokens[0m[38;2;248;248;242m)[0m[38;2;248;248;242m, [0m[38;2;230;219;116m"Could not forward funds due to an unknown error."[0m
[38;2;248;248;242m    [0m[38;2;248;248;242mlog[0m[38;2;248;248;242m.[0m[38;2;102;217;239mTokenPurchase[0m[38;2;248;248;242m([0m[38;2;248;248;242m_sender, _beneficiary, _weiAmount, tokens[0m[38;2;248;248;242m)[0m

[38;2;248;248;242m    [0m[38;2;117;113;94m#[0m[38;2;117;113;94mforward funds to the receiving wallet address.[0m
[38;2;248;248;242m    [0m[38;2;102;217;239msend[0m[38;2;248;248;242m([0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.wallet, _weiAmount[0m[38;2;248;248;242m)[0m

[38;2;248;248;242m    [0m[38;2;117;113;94m#[0m[38;2;117;113;94mpost validate[0m

[38;2;249;38;114m@public[0m
[38;2;249;38;114m@payable[0m
[3;38;2;102;217;239mdef[0m[38;2;248;248;242m [0m[38;2;166;226;46mbuyTokens[0m[38;2;248;248;242m([0m[3;38;2;253;151;31m_beneficiary[0m[38;2;248;248;242m: [0m[38;2;190;132;255maddress[0m[38;2;248;248;242m)[0m[38;2;249;38;114m:[0m
[38;2;248;248;242m    [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.[0m[38;2;102;217;239mprocessTransaction[0m[38;2;248;248;242m([0m[38;2;190;132;255mmsg.sender[0m[38;2;248;248;242m, _beneficiary, [0m[38;2;190;132;255mmsg.value[0m[38;2;248;248;242m)[0m

[38;2;249;38;114m@public[0m
[38;2;249;38;114m@payable[0m
[3;38;2;102;217;239mdef[0m[38;2;248;248;242m [0m[38;2;166;226;46m__default__[0m[38;2;248;248;242m([0m[38;2;248;248;242m)[0m[38;2;249;38;114m:[0m
[38;2;248;248;242m    [0m[3;38;2;102;217;239mself[0m[38;2;248;248;242m.[0m[38;2;102;217;239mprocessTransaction[0m[38;2;248;248;242m([0m[38;2;190;132;255mmsg.sender[0m[38;2;248;248;242m, [0m[38;2;190;132;255mmsg.sender[0m[38;2;248;248;242m, [0m[38;2;190;132;255mmsg.value[0m[38;2;248;248;242m)[0m