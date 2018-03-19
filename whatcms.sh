#!/bin/bash

#SET YOUR WHATCMS API KEY HERE
cmsapikey=157de12e36b7d537764f3e7c80ce69a5440be19bab9359c3921a7931314fea5fed18d1

#Banner function
banner()
{
	echo ""
	echo "-------------------------------------------------------------"	
	echo ""
	echo ""
	echo -e "\e[1;36m██╗    ██╗██╗  ██╗ █████╗ ████████╗ ██████╗███╗   ███╗███████╗"
	echo -e "██║    ██║██║  ██║██╔══██╗╚══██╔══╝██╔════╝████╗ ████║██╔════╝"
	echo -e "██║ █╗ ██║███████║███████║   ██║   ██║     ██╔████╔██║███████╗"
	echo -e "██║███╗██║██╔══██║██╔══██║   ██║   ██║     ██║╚██╔╝██║╚════██║"
	echo -e "╚███╔███╔╝██║  ██║██║  ██║   ██║   ╚██████╗██║ ╚═╝ ██║███████║"
	echo -e " ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝     ╚═╝╚══════╝\e[0m"
    echo ""
    echo ""                                                          
	echo -e "   CMS Detection and Exploit Kit based on \e[1mWhatCMS.org\e[0m API"
	echo ""
	echo -e "\e[1m  --------------------\e[0m"
	echo -e "\e[1m |\e[0m \e[1;36mCMS database: 331\e[0m  \e[1m|\e[0m"
	echo -e "\e[1m |\e[0m \e[1;36mTools database: 44\e[0m \e[1m|\e[0m"
	echo -e "\e[1m  --------------------\e[0m"
	echo -e "                                           \e[2;3;36mdeveloped by HATI\e[0m"
	echo "-------------------------------------------------------------"
}

#APIKEYcheck
apikeycheck()
{
	if [[ -z $cmsapikey ]];then
		echo ""
		echo -e " \e[38;5;196;1m[#] API Key not found.\e[0m"
		echo -e " \e[1m[-] Set your WhatCMS API Key on the source code\e[0m"
		echo ""
		exit 0
	fi
}

#TrashDel
trashdel()
{
	echo " " > tmpver
	rm tmpver
	echo " " > tmptools2
	rm tmptools2
	echo " " > tmpgit
	rm tmpgit
	echo " " > tmptools
	rm tmptools
	echo " " > tmp
	rm tmp
	echo " " > cmstmp
	rm cmstmp
}

#DomainCheck function
domaincheck()
{
	if [[ -z $1 ]];then
		echo ""
	else
		verify=$(echo $1 | grep -c -P '^(?!:\/\/)(?=.{1,255}$)((.{1,63}\.){1,127}(?![0-9]*$)[a-z0-9-]+\.?.*)')
		if [ $verify != 0 ]; then
			echo ""
		fi
	fi
}

#WhatCMS function
whatcms()
{
    curl -s "https://whatcms.org/APIEndpoint?key=$cmsapikey&url="$1 > tmp
    api=$(cat tmp | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^msg/ {print $2}' | sed 's/\(^"\|"$\)//g' | grep -c Invalid)
    if [[ $api == 1 ]];then
    	echo -e " \e[38;5;196;1m[#] Invalid API key.\e[0m"
    	echo -e " \e[1m[-] Set your WhatCMS API Key on the source code.\e[0m"
    	echo ""
    	exit 0
    else
    	cms=$(cat tmp | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^name/ {print $2}' | sed 's/\(^"\|"$\)//g')
    	version=$(cat tmp | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^version/ {print $2}' | sed 's/\(^"\|"$\)//g')
    	echo ""
    	echo -e " \e[1m[URL]: \e[1;36m$1\e[0m"
    	echo ""
    	echo -e " \e[1m[CMS]: \e[1;92m$cms\e[0m"
    	echo ""
    	echo -e " \e[1m[VERSION]: \e[1;92m$version\e[0m"
    fi
}

#WhoHOST function
whohost()
{
	curl -s "https://www.who-hosts-this.com/APIEndpoint?key=$cmsapikey&url="$1 > tmp
	api=$(cat tmp | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^msg/ {print $2}' | sed 's/\(^"\|"$\)//g' | grep -c Invalid)
  	isp=$(cat tmp | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^isp_name/ {print $2}' | sed 's/\(^"\|"$\)//g' | sort | uniq | tr '\n' ' ')
	ip=$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' tmp | sort | uniq | tr '\n' ' ')
	type=$(cat tmp | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^type/ {print $2}' | sed 's/\(^"\|"$\)//g' | sort | uniq | tr '\n' ' ')
	echo ""
	echo -e " \e[1m[ISP]: \e[1;36m$isp\e[0m"
	echo ""
	echo -e " \e[1m[IP]: \e[1;36m$ip\e[0m"
	echo ""
	echo -e " \e[1m[TYPE] \e[1;36m$type\e[0m"
}

#CMSToolsask function
cmstoolsask()
{
	echo ""
	echo "-------------------------------------------------------------"
	echo  -e "DruPal\nJoomla\nSPIP\nWordpress\nDrupal\nXen\nBigTreeCMS\nDrupal\nWeBid\nDiscuz\nvbulletin\nHeroku\nOpenCart\nPHPBB\nBugzilla\nMambo\nWolf\nStartBBS\nMadeSimple\nVeyton\nMagento\nMagento\nshopify\nMagento\nPrestashop\nMoodle\nmyBB\nCentreon\nTYPO3CMS\nBetoffice\nWaiKu\nLokomedia\nOpenCart\nuseBB\nEZPublish\nClaroline\nFly-High\nAllCMS\nxt-commerce\nvanilla\nTypo3\nPlone\nsquarespace\nClipperCMS\nPrestashop\nHavalite\nWebspell\ntumblr\nbbPress\nPhpMyAdmin\nCMSMS\nPivotX\nPhpTax\nCMSimple\nAlchemyCMS\nimacs\nMantis\nCollabtive\nConcrete5\nCoppermine\nCotonti\nCroogo\nCubeCart\nDolibarr\nDotclear\ne107\nEspoCRM\nEtherpad\nFluxBB\nFoswiki\nGallery\nGollum\nHelpDEZk\nHumHub\nImpressCMS\nImpressPages\nJamroom\nKanboard\nKCFinder\nLiteCart\nMagnolia\nMahara\nMantisBT\nMediaWiki\nMicroweber\nMiniBB\nMODXRevolution\nMoinMoin\nNibbleblog\nOpenSourceSocialNetwork\nOpenCart\nosDate\nownCloud\nOxwall\nPBBoard\nphpBB3\nPhpGedView\nPiwigo\nPiwik\nPmWiki\nPostfixAdmin\nRedaxo\nRoundcube\nSaurusCMS\nSerendipity\nShaarli\nSimple Machines Forum\nSpinaCMS\nSquirrelMail\nTestLink\nTikiWiki\nTrac\nWikkaWiki\nZenphoto\nX-Cart\nZikula\nMoodle\nBeehive\nFUDforum\npunBB\nAcmImBoard\nBurning\nCommunity\nfusionBB\ndeluxeBB\nJFORUM\nJive\nJibit\nNear\nOVBB\nTikiWiki\nSPIP\nConcrete5" > cmstmp
	verify=$(grep -c -i "$cms" cmstmp)
	if [[ $cms == "null" ]];then
		echo ""
		echo -e " \e[38;5;196;1m[#] CMS not detected.\e[0m"
		echo ""
		echo "-------------------------------------------------------------"
		echo ""
		exit 0
	elif [[ $verify == 0 ]];then
		echo ""   
        echo -e " \e[38;5;196;1m[#] The CMS is not on the tool database.\e[0m"
        echo ""
        echo "-------------------------------------------------------------"
		echo ""
		exit 0
   	else
   		echo ""
        echo -e " \e[1;92m[+] CMS found on the tool database.\e[0m "
        echo -e " \e[1m[-]Wanna check wich tools can you use? [y/n] \e[0m" 
        read -s checkyn
        echo ""
	fi
}

#CMSToolscheck function
cmstoolscheck()
{
	case $checkyn in
	    Y|y|s|S|"")	 	
	 	;;
	    n|N)
			echo ""
			echo -e " \e[1;36mBye bye.\e[0m"
			echo ""
			trashdel
			exit 0
	    ;;	 
	    *)
			echo ""
			trashdel
			exit 0
		;;
	esac
}

#CMSTools
cmstools()
{
	xbf=$(echo $XBruteForcer | cut -d "-" -f 5 | grep -c -i "$cms")
	CMSs4=$(echo $CMSsc4n | cut -d "-" -f 5 | grep -c -i "$cms")
	CMSon=$(echo $CoMisSion | cut -d "-" -f 5 | grep -c -i "$cms")
	droop=$(echo $droopescan | cut -d "-" -f 5 | grep -c -i "$cms")
	map=$(echo $CMSmap | cut -d "-" -f 5 | grep -c -i "$cms")
	joom=$(echo $JoomScan | cut -d "-" -f 5 | grep -c -i "$cms")
	bee=$(echo $beecms | cut -d "-" -f 5 | grep -c -i "$cms")
	dumb=$(echo $Dumb0 | cut -d "-" -f 5 | grep -c -i "$cms")
	vbs=$(echo $VBScan | cut -d "-" -f 5 | grep -c -i "$cms")
	joom2=$(echo $JoomlaScan | cut -d "-" -f 5 | grep -c -i "$cms")
	c5=$(echo $c5scan | cut -d "-" -f 5 | grep -c -i "$cms")
	t3=$(echo $T3scan | cut -d "-" -f 5 | grep -c -i "$cms")
	pup=$(echo $Puppet | cut -d "-" -f 5 | grep -c -i "$cms")
	mood=$(echo $moodlescan | cut -d "-" -f 5 | grep -c -i "$cms")
	spip=$(echo $SPIPScan | cut -d "-" -f 5 | grep -c -i "$cms")
	wphu=$(echo $WPHunter | cut -d "-" -f 5 | grep -c -i "$cms")
	wpsek=$(echo $WPSeku | cut -d "-" -f 5 | grep -c -i "$cms")
	acdr=$(echo $acdrupal | cut -d "-" -f 5 | grep -c -i "$cms")
	plo=$(echo $Plown | cut -d "-" -f 5 | grep -c -i "$cms")
	pyf=$(echo $pyfiscan | cut -d "-" -f 5 | grep -c -i "$cms")
	con=$(echo $conscan | cut -d "-" -f 5 | grep -c -i "$cms")
	cmsss=$(echo $CMSScanner | cut -d "-" -f 5 | grep -c -i "$cms")
	cmse=$(echo $cmsexplorer | cut -d "-" -f 5 | grep -c -i "$cms")
	wpsc=$(echo $WPScan | cut -d "-" -f 5 | grep -c -i "$cms")
	xplsc=$(echo $XPL | cut -d "-" -f 5 | grep -c -i "$cms")
	jme=$(echo $JoomME | cut -d "-" -f 5 | grep -c -i "$cms")
	wme=$(echo $WordPressME | cut -d "-" -f 5 | grep -c -i "$cms")
	cef=$(echo $CMSEF | cut -d "-" -f 5 | grep -c -i "$cms")
	lcms=$(echo $Lotus | cut -d "-" -f 5 | grep -c -i "$cms")
	bmcms=$(echo $BadMod | cut -d "-" -f 5 | grep -c -i "$cms")
	moo=$(echo $MooScan | cut -d "-" -f 5 | grep -c -i "$cms")
	xa=$(echo $XAttacker | cut -d "-" -f 5 | grep -c -i "$cms")
	mob=$(echo $M0B | cut -d "-" -f 5 | grep -c -i "$cms")
	lmfi=$(echo $LetMeFuckIt | cut -d "-" -f 5 | grep -c -i "$cms")
	mcms=$(echo $magescan | cut -d "-" -f 5 | grep -c -i "$cms")
	pcms=$(echo $PRESTA | cut -d "-" -f 5 | grep -c -i "$cms")
	scms=$(echo $sc | cut -d "-" -f 5 | grep -c -i "$cms")
	ekcms=$(echo $ektrone | cut -d "-" -f 5 | grep -c -i "$cms")
	lrs=$(echo $LiferayScan | cut -d "-" -f 5 | grep -c -i "$cms")
	ifl=$(echo $InfoLeak | cut -d "-" -f 5 | grep -c -i "$cms")
	jlavs=$(echo $joomlavs | cut -d "-" -f 5 | grep -c -i "$cms")
	was=$(echo $WAScan | cut -d "-" -f 5 | grep -c -i "$cms")
	rhw=$(echo $RedHawk | cut -d "-" -f 5 | grep -c -i "$cms")
	hostsbf=$(echo $HostileSBF | cut -d "-" -f 5 | grep -c -i "$cms")

	echo "-------------------------------------------------------------"
	echo ""
	echo -e " \e[1m[-] Available tools for \e[1;36m$cms:\e[0m"
	echo ""
	echo ""
	echo "" > tmptools
	echo -e " \e[1m           TOOL        - ID -         UTILITY\e[0m" >> tmptools
	echo "     __________________-____-________________________" >> tmptools

	if [[ $xbf == 1 ]];then
		echo "     "$XBruteForcer | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $CMSs4 == 1 ]]; then
		echo "     "$CMSsc4n | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $CMSon == 1 ]]; then
		echo "     "$CoMisSion | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $droop == 1 ]]; then
		echo "     "$droopescan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $map == 1 ]]; then
		echo "     "$CMSmap | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $joom == 1 ]]; then
		echo "     "$JoomScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $bee == 1 ]]; then
		echo "     "$beecms | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $dumb == 1 ]]; then
		echo "     "$Dumb0 | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $vbs == 1 ]]; then
		echo "     "$VBScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $joom2 == 1 ]]; then
		echo "     "$JoomlaScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $c5 == 1 ]]; then
		echo "     "$c5scan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $t3 == 1 ]]; then
		echo "     "$T3scan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $pup == 1 ]]; then
		echo "     "$Puppet | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $mood == 1 ]]; then
		echo "     "$moodlescan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $spip == 1 ]]; then
		echo "     "$SPIPScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $wphu == 1 ]]; then
		echo "     "$WPHunter | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $wpsek == 1 ]]; then
		echo "     "$WPSeku | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $acdr == 1 ]]; then
		echo "     "$acdrupal | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $plo == 1 ]]; then
		echo "     "$Plown | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $pyf == 1 ]]; then
		echo "     "$pyfiscan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $con == 1 ]]; then
		echo "     "$conscan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $cmsss == 1 ]]; then
		echo "     "$CMSScanner | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $cmse == 1 ]]; then
		echo "     "$cmsexplorer | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $wpsc == 1 ]]; then
		echo "     "$WPScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $xplsc == 1 ]]; then
		echo "     "$XPL | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $jme == 1 ]]; then
		echo "     "$JoomME | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $wme == 1 ]]; then
		echo "     "$WordPressME | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $cef == 1 ]]; then
		echo "     "$CMSEF | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $lcms == 1 ]]; then
		echo "     "$Lotus | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $bmcms == 1 ]]; then
		echo "     "$BadMod | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $moo == 1 ]]; then
		echo "     "$MooScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $mob == 1 ]]; then
		echo "     "$M0B | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $lmfi == 1 ]]; then
		echo "     "$LetMeFuckIt | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $mcms == 1 ]]; then
		echo "     "$magescan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $pcms == 1 ]]; then
		echo "     "$PRESTA | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $scms == 1 ]]; then
		echo "     "$sc | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $ekcms == 1 ]]; then
		echo "     "$ektrone | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $lrs == 1 ]]; then
		echo "     "$LiferayScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $ifl == 1 ]]; then
		echo "     "$InfoLeak | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $jlavs == 1 ]]; then
		echo "     "$joomlavs | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $was == 1 ]]; then
		echo "     "$WAScan | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $rhw == 1 ]]; then
		echo "     "$RedHawk | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	if [[ $hostsbf == 1 ]]; then
		echo "     "$HostileSBF | cut -d "-" -f 1,2,3 >> tmptools
		echo "     __________________-____-________________________" >> tmptools
	fi
	column -t -s "-" tmptools
	echo ""
}

#CMStoolsaskdown
cmstoolsaskdown()
{
	echo "-------------------------------------------------------------"
	echo ""
	echo -e " \e[1m[-] Wanna use any tool in the table? [y/n]\e[0m"
	read -s checkyn
}

#cmstoolsgit
cmstoolsgit()
{
	echo ""
	cat tmptools | cut -d "-" -f 1 | grep -v "_" > tmptools2
	sed -i -e "1d;2d" tmptools2
	echo -e " \e[1m[-] Enter the tool ID\e[0m:"
	read -s -a id
	idver=$(echo ${id[@]} | grep -o " " | wc -l)
	#idver=$(echo $idver + 1 | bc)

	
	
	while read line;
	do	
		con=0
		con2=0
		while [[ $con -le $idver ]]
			do
			echo ${!line} | grep -w -c "${id[$con2]}" > tmpver
			tmpverr=$(cat tmpver)
			
				if [[  $tmpverr == "1" ]];then
					echo ${!line} | cut -d "-" -f 4 > tmpgit
					github=$(cat tmpgit)
					echo ""
					git clone $github /root/cmstools/$line
					echo ""
					echo -e " \e[1;36m[+] Tool cloned in\e[0m \e[1;96m/root/cmstools/$line.\e[0m"
					echo ""
					(( con2 += 1 ))
					(( con += 1 ))
				else
					(( con2 += 1 ))
					(( con += 1 ))
				fi
			done		
			
	done < tmptools2
}

#Help function
helpf()
{
	
	coomandarray=("-h" '-wh' '--tools' )
	msgarray=('Display this help message' 'Check hosting details' 'Tools information')
	array_size=3
	echo ""
	echo -e " \e[1m[+] Usage:\e[0m \e[3m./whatcms.sh example.com\e[0m"
	echo ""
	echo -e " \e[1m[+] Command list:\e[0m"
	echo ""

	for((i=0;i<array_size;i++))
	do
    	echo "      " ${coomandarray[$i]} $'\x1d' ${msgarray[$i]}
	done | column -t -s$'\x1d'
}

#Toolspack function
toolspack()
{
	cms=""
	cmstools
}

#Tools info
XBruteForcer=' XBruteForcer - 1 - Brute Force Tool - https://github.com/Moham3dRiahi/XBruteForcer - WordPress, Joomla, DruPal, OpenCart, Magento' 
CMSsc4n=' CMSsc4n - 2 - Identify Tool - https://github.com/n4xh4ck5/CMSsc4n - Wordpress, Moodle, Joomla, Drupal, Prestashop'
CoMisSion=' CoMisSion - 3 - Analyze Tool - https://github.com/Intrinsec/comission - Wordpress, Drupal'
droopescan=' droopescan - 4 - Analyze Tool - https://github.com/droope/droopescan - Drupal, SilverStripe CMS, Wordpress, Joomla, Moodle'
CMSmap=' CMSmap - 5 - Analyze Tool - https://github.com/Dionach/CMSmap - WordPress, Joomla, Drupal'
JoomScan=' JoomScan - 6 - Analyze Tool - https://github.com/rezasp/joomscan - Joomla'
beecms=' beecms - 7 - Exploit Tool - https://github.com/CHYbeta/cmsPoc - beecms'
Dumb0=' Dumb0 - 8 - Username Scrapper Tool - https://github.com/0verl0ad/Dumb0/ - Simple Machines Forum, Invision, Xen, vBulletin, myBB, useBB, vanilla, bbPress, WordPress, SPIP, Drupal, Moodle, Beehive, fluxBB, FUDforum, punBB, AcmImBoard, Burning, Community, deluxeBB, fusionBB, JFORUM, Jibit, Jive, Near, OVBB, TikiWiki'
VBScan=' VBScan - 9 - Analyze Tool - https://github.com/rezasp/vbscan - vBulletin'
JoomlaScan=' JoomlaScan - 10 - Analyze Tool - https://github.com/drego85/JoomlaScan - Joomla'
c5scan=' c5scan - 11 - Analyze Tool - https://github.com/auraltension/c5scan - Concrete5'
T3scan=' T3scan - 12 - Analyze Tool - https://github.com/Oblady/T3Scan - TYPO3'
Puppet=' Puppet - 13 - Identify Tool - https://github.com/Poil/puppet-websites-facts - Joomla, Drupal, Wordpress, PHPBB, Magento, EZPublish, Typo3, PhpMyAdmin, Mantis, SPIP'
moodlescan=' moodlescan - 14 - Analyze Tool - https://github.com/inc0d3/moodlescan - Moodle'
SPIPScan=' SPIPScan - 15 - Analyze Tool - https://github.com/PaulSec/SPIPScan - SPIP'
WPHunter=' WPHunter - 16 - Analyze Tool - https://github.com/aryanrtm/WP-Hunter - WordPress'
WPSeku=' WPSeku - 17 - Analyze Tool - https://github.com/m4ll0k/WPSeku - WordPress'
acdrupal=' ACDrupal - 18 - Analyze Tool - https://github.com/mrmtwoj/ac-drupal - Drupal'
Plown=' Plown - 19 - Analyze Tool - https://github.com/unweb/plown - Plown'
pyfiscan=' pyfiscan - 20 - Identify Tool - https://github.com/fgeek/pyfiscan - ATutor, b2evolution, BigTree CMS, Bugzilla, Centreon, Claroline, ClipperCMS, CMSimple, CMSMS, Collabtive, Concrete5, Coppermine, Cotonti, Croogo, CubeCart, Dolibarr, Dotclear, Drupal, e107, EspoCRM, Etherpad, FluxBB, Foswiki, Gallery, Gollum, HelpDEZk, HumHub, ImpressCMS, ImpressPages, Jamroom, Joomla, Kanboard, KCFinder, LiteCart, Magnolia, Mahara, MantisBT, MediaWiki, Microweber, MiniBB, MODX Revolution, MoinMoin, MyBB, Nibbleblog, Open Source Social Network, OpenCart, osDate, ownCloud, Oxwall, PBBoard, phpBB3, PhpGedView, phpMyAdmin, Piwigo, Piwik, PmWiki, Postfix Admin, Redaxo, Roundcube, SaurusCMS, Serendipity, Shaarli, Simple Machines Forum, Spina CMS, SPIP, SquirrelMail, TestLink, TikiWiki, Trac, WikkaWiki, WordPress, X-Cart, Zenphoto, Zikula'
conscan=' conscan - 21 - Analyze Tool - https://github.com/nullsecuritynet/tools/tree/master/scanner/conscan - Concrete5'
CMSScanner=' CMSScanner - 22 - Analyze Tool - https://github.com/CMS-Garden/cmsscanner - Contao, CONTENIDO, Drupal, Joomla, TYPO3 CMS, WordPress, Prestashop, Alchemy CMS, PivotX, Concrete5'
cmsexplorer=' cmsExplorer - 23 - Analyze Tool - https://code.google.com/archive/p/cms-explorer/ - Drupal, Wordpress, Joomla, Mambo'
WPScan=' WPScan - 24 - Analyze Tool - https://github.com/wpscanteam/wpscan - WordPress'
XPL=' CMSXPL - 25 - Exploit Tool - https://github.com/tanprathan/CMS-XPL - 230cms, Bloofox, WeBid, Wolf, Betoffice, Fly-High, Havalite, imacs, PhpTax'
JoomME=' JMassExploiter - 26 - Exploit Tool - https://github.com/anarcoder/JoomlaMassExploiter - Joomla'
WordPressME=' WPMassExploiter - 27 - Exploit Tool - https://github.com/anarcoder/WordPressMassExploiter - Wordpress'
CMSEF=' CMSExpFram - 28 - Exploit Tool - https://github.com/Q2h1Cg/CMS-Exploit-Framework - Wordpress, ThinkPHP, Discuz, StartBBS, WaiKu, AllCMS'
Lotus=' LotusXploit - 29 - Exploit Tool - https://github.com/Hood3dRob1n/LotusCMS-Exploit - Lotus'
BadMod=' BadMod - 30 - Exploit Tool - https://github.com/MrSqar-Ye/BadMod - Wordpress, Drupal, Joomla, MadeSimple'
MooScan=' MooScan - 31 - Analyze Tool - https://github.com/vortexau/mooscan - Moodle'
XAttacker=' XAttacker - 32 - Exploit Tool -	https://github.com/Moham3dRiahi/XAttacker - Wordpress, Joomla, Drupal, Lokomedia, Prestashop'	
M0B=' M0B - 33 - Exploit Tool - https://github.com/mobrine-mob/M0B-tool - Wordpress, Magento, Joomla, Drupal, OpenCart'
LetMeFuckIt=' LetMeFuckIt - 34 - Exploit Tool - https://github.com/onthefrontline/LetMeFuckIt-Scanner - Magento'
magescan=' magescan - 35 - Exploit Tool - https://github.com/steverobbins/magescan - Magento'
PRESTA=' PRESTA - 36 - Exploit Tool - https://github.com/AlisamTechnology/PRESTA-modules-shell-exploit - Prestashop'
sc=' Scanners - 37 - Analyze Tool - https://github.com/b3o1/Scanners - Wordpress, Joomla'
ektrone=' EktronE - 38 - Exploit Tool - https://github.com/tomkallo/Ektron_CMS_8.02_exploit - Ektron'
LiferayScan=' LiferayScan - 39 - Analyze Tool - https://github.com/bcoles/LiferayScan - Liferay'
InfoLeak=' InfoLeak - 40 - Analyze Tool - https://github.com/SIWECOS/InfoLeak-Scanner - Drupal, Joomla, vbulletin, Veyton, Webspell, Wordpress, xt-commerce'
joomlavs=' joomlavs - 41 - Analyze Tool - https://github.com/rastating/joomlavs - Joomla'
WAScan=' WAScan - 42 - Analyze Tool - https://github.com/m4ll0k/WAScan - Drupal, SilverStripe CMS, Joomla, Magento, Wordpress, Plone'
RedHawk=' RedHawk - 43 - Analyze Tool - https://github.com/Tuhinshubhra/RED_HAWK - Wordpress, Drupal, Joomla, Magento'
HostileSBF=' HostileSBF - 44 - Analyze Tool - https://github.com/nahamsec/HostileSubBruteforcer - AWS, Github, Heroku, shopify, tumblr, squarespace'

#-------------------------------------------------------------------------------------------------------------------------------
banner
apikeycheck
domaincheck $1
if [[ -z $1 ]];then
	helpf
	echo ""
	trashdel
	exit 0
else
	if [[ $verify != "0" ]];then
		whatcms $1
		if [[ $2 == "-wh" ]];then
			sleep 9
			whohost $1
		fi
		cmstoolsask
		cmstoolscheck
		cmstools
		cmstoolsaskdown
		cmstoolscheck
		cmstoolsgit
	else
		if [[ $1 != "" ]];then
			if [[ $1 == "--tools" ]];then
				echo ""
				toolspack
				echo ""
				exit 0
			elif [[ $1 == "--help" ]] || [[ $1 == "-h" ]];then
				helpf
				echo ""
				exit 0
			elif [[ $1 != "--help" ]] || [[ $1 != "--tools" ]] || [[ $1 != "-h" ]]; then
				echo ""
				echo -e " \e[38;5;196;1m[#] Invalid domain or parameter\e[0m"
				echo ""
			else
				echo ""
				trashdel
				exit 0
			fi
		fi
	fi
fi

trashdel
exit 0